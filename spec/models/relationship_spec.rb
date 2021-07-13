require 'rails_helper'
# https://qiita.com/narimiya/items/11429a0064383fb177ee
RSpec.describe Relationship, type: :model do
  before do
    @user1 = FactoryBot.build(:user)
    @user2 = FactoryBot.build(:user)
    @relationship = FactoryBot.build(:relationship)
  end

  describe 'フォロー' do
    context 'フォローが可能の場合' do
      it "全てのパラメーターが揃っている" do
        expect(@relationship).to be_valid
      end
    end

    context 'フォローが不可の場合' do
      it "user_idがnil" do
        @relationship.follow_id = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include("Followを入力してください")
      end
      it "follow_idがnil" do
        @relationship.user_id = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include("Userを入力してください")
      end
    end
    
    context "一意性の検証" do
      before do
        @relation = FactoryBot.create(:relationship)
        @user1 = FactoryBot.build(:relationship)
      end
      it 'user_idとfollow_idの組み合わせは一意でなければ保存できない' do
        relation2 = FactoryBot.build(:relationship, user_id: @relation.user_id, follow_id: @relation.follow_id)
        relation2.valid?
        expect(relation2.errors.full_messages).to include("Userはすでに存在します")
      end
      it 'user_idが同じでもfollow_idが違うなら保存できる' do
        relation2 = FactoryBot.build(:relationship, user_id: @relation.follow_id, follow_id: @user1.follow_id)
        expect(relation2).to be_valid
      end
      it 'user_idが違うならfollow_idが同じでも保存できる' do
        relation2 = FactoryBot.build(:relationship, user_id: @user1.user_id, follow_id: @relation.follow_id)
        expect(relation2).to be_valid
      end
    end
  end

  describe 'アソシエーション' do
    context 'モデルとの関係' do
      it 'User' do
        expect(Relationship.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end  
  end
  
end
