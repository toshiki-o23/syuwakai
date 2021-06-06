require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user1 = FactoryBot.build(:user)
    @user2 = FactoryBot.build(:user)
    @relationship = FactoryBot.build(:relationship)
  end

  describe '#create' do
    context '保存できる場合' do
      it "全てのパラメーターが揃っていれば保存できる" do
        expect(@relationship).to be_valid
      end
    end

    context '保存できない場合' do
      it "user_idがnilの場合、保存できない" do
        @relationship.follow_id = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include("Followを入力してください")
      end
      it "follow_idがnilの場合、保存できない" do
        @relationship.user_id = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include("Userを入力してください")
      end
    end
    
  end
end
