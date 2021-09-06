require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event, user_id: @user.id)
    @user_event = FactoryBot.create(:user_event, event_id: @event.id, user_id: @user.id)
  end
  let(:comment_params) {{ user_id: @user.id, event_id: @event.id, content: "test"}}

  describe "ログイン済み" do
    it "お知らせ送る" do
      sign_in @user
      expect do
        post event_comments_path(event_id: @event.id), params: { comment: comment_params }
      end.to change(Comment, :count).by(1)
    end
  end
end