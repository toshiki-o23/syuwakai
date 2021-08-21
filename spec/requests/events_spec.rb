require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "イベント投稿画面 (events_path) #new" do
    context "未ログイン" do
      it "イベント投稿画面からログイン画面へリダイレクト" do
        get new_event_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済み" do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end
      it "イベント投稿画面" do
        get new_event_path
        expect(response).to have_http_status "200"
      end
    end
  end
end
