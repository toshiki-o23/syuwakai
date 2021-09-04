require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe "ログイン済み" do
    it "ユーザー詳細画面 show" do
      sign_in @user
      get user_path(@user)
      expect(response).to have_http_status(200)
      expect(response.body).to include 'test_user'
    end
  end
end