require 'rails_helper'
# https://qiita.com/narimiya/items/8ec3cdc15b1134b04dce

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe 'ユーザー新規登録' do
    context '新規登録が可能の場合' do
      it "内容に問題ない" do
        expect(@user).to be_valid
      end
      it "nameが30文字以下" do
        @user.name = 'a' * 30
        expect(@user).to be_valid
      end
      it 'emailが255文字以下' do
        @user.email = 'a' * 245 + '@sample.js'
        expect(@user).to be_valid
      end
      it 'emailは全て小文字で保存' do
        @user.email = 'SAMPLE@SAMPLE.JP'
        @user.save!
        expect(@user.reload.email).to eq 'sample@sample.jp'
      end
    end

    context '新規登録が不可の場合' do
      it "nameが空" do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it "nameが31文字以上" do
        @user.name = 'a' * 31
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は30文字以内で入力してください")
      end
      it "emailが空" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it "emailが256文字以上" do
        @user.email = 'a' * 246 + '@sample.js'
        @user.valid?
        expect(@user.errors).to be_added(:email, :too_long, count: 255)
      end
      it "emailが正しくない形式" do
        @user.email = "toshiki"
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end
      it "emailが重複" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end
      it "passwordが空" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが存在してもpassword_confirmationが空' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('確認用パスワードとパスワードの入力が一致しません')
      end
    end
  end

  describe 'アソシエーション' do
    context 'モデルとの関係' do
      it 'Event' do
        expect(User.reflect_on_association(:events).macro).to eq :has_many
      end
      it 'Bookmark' do
        expect(User.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
      it 'Relationship' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
    end
  end
end



