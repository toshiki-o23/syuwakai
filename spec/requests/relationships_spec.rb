require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
  end

  describe 'create' do

    it 'フォローする,フォロー解除する' do
      sign_in @user
      post relationships_path(follow_id: @other_user.id)
      expect(@other_user.followers.count).to eq(1)
      expect(@user.followings.count).to eq(1)

      delete relationship_path(id: @user.id, follow_id: @other_user.id)
      expect(@other_user.followers.count).to eq(0)
      expect(@user.followings.count).to eq(0)
    end
  end

end