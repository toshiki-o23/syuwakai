require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event, user_id: @user.id)
    sign_in @user
  end
  let(:bookmark_params) {{ user_id: @user.id, event_id: @event.id }}

  describe "create" do
    it "ブックマークする" do
      expect do
        sign_in @user
        post event_bookmarks_path(@event), params: { bookmark: bookmark_params} 
      end.to change(Bookmark, :count).by(1)
    end
  end
  describe "destroy" do
    let!(:bookmark) {create(:bookmark, user_id: @user.id, event_id: @event.id)}
    it "ブックマーク解除する" do
      expect do
        sign_in @user
        delete event_bookmarks_path(event_id: @event.id, id: bookmark.id), params: { bookmark: bookmark.id } 
      end.to change(Bookmark, :count).by(-1)
    end
  end
end
