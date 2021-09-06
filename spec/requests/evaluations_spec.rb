require 'rails_helper'

RSpec.describe "Evaluations", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event, user_id: @user.id)
    @user_event = FactoryBot.create(:user_event, event_id: @event.id, user_id: @user.id)
    @evaluation = FactoryBot.create(:evaluation, event_id: @event.id, user_id: @user.id)
  end
  let(:evaluation_params) {{ user_id: @user.id, event_id: @event.id, comment: "test"}}

  describe "ログイン済み" do
    it "評価する" do
      sign_in @user
      post evaluations_path, params: { evaluation: evaluation_params }
      expect(response).to redirect_to event_user_event_path(@user_event, @event)
    end
  end
end