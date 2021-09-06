require 'rails_helper'

RSpec.describe "Events", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event, user_id: @user.id)
  end

  describe "ログイン済み" do
    it "投稿一覧画面 index" do
      sign_in @user
      get root_path
      expect(response).to have_http_status(200)
    end
    it "投稿詳細画面 show" do
      sign_in @user
      get event_path(@event)
      expect(response).to have_http_status(200)
      expect(response.body).to include 'お知らせを送る'
    end
    it "新規投稿画面 new" do
      sign_in @user
      get new_event_path
      expect(response).to have_http_status(200)
    end
    it "新規投稿→投稿詳細画面 create" do
      sign_in @user
      post events_path, params: { event: FactoryBot.attributes_for(:event)}
      expect(response).to redirect_to Event.last
    end
    it "投稿削除→マイページ画面 delete" do
      sign_in @user
      delete event_path(Event.last)
      expect(response).to redirect_to user_path(@user)
    end
  end

  describe "未ログイン" do
    it "投稿一覧画面 index" do
      get root_path
      expect(response).to have_http_status(200)
    end
    it "新規投稿画面からログイン画面へリダイレクト" do
      get new_event_path
      expect(response).to redirect_to new_user_session_path
    end
  end
end
