require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe 'ユーザー新規登録' do
    context '新規登録ができたとき' do
      it "内容に問題ない場合" do
        expect(@user).to be_valid
      end
      it 'emailが255文字以下のユーザーが作成可能' do
        @user.email = 'a' * 245 + '@sample.js'
        expect(@user).to be_valid
      end
      it 'emailは全て小文字で保存される' do
        @user.email = 'SAMPLE@SAMPLE.JP'
        @user.save!
        expect(@user.reload.email).to eq 'sample@sample.jp'
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nameが空の場合、登録できない" do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it "emailが空の場合、登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it "重複したemailが存在する場合、登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end
      it "emailが256文字以上のユーザーを許可しない" do
        @user.email = 'a' * 246 + '@sample.js'
        @user.valid?
        expect(@user.errors).to be_added(:email, :too_long, count: 255)
      end
      it "passwordが空の場合、登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが存在してもpassword_confirmationが空の場合、登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('確認用パスワードとパスワードの入力が一致しません')
      end
    end
  end
end



