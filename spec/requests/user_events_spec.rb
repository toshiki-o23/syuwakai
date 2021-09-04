require 'rails_helper'

RSpec.describe "UserEvents", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event, user_id: @user.id)
    @user_event = FactoryBot.create(:user_event, event_id: @event.id, user_id: @user.id)
  end

  describe "ログイン済み" do
    it "参加予約する" do
      sign_in @user
      post event_user_events_path(@user_event, event_id: @event.id)
      expect(response).to redirect_to event_user_event_path(event_id: 2, id: @event.id)
    end
  end
end