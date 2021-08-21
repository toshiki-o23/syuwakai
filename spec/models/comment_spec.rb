require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event)
    @comment = FactoryBot.build(:comment, user_id: @user.id, event_id: @event.id)
  end

  describe 'お知らせ送信' do
    context 'お知らせが可能の場合' do
      it "内容に問題ない" do
        expect(@comment).to be_valid
      end
      it "contentが10000文字以下" do
        @comment.content = 'a' * 10000
        expect(@comment).to be_valid
      end
    end

    context 'お知らせが不可の場合' do
      it "contentが空" do
        @comment.content = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("お知らせ内容を入力してください")
      end
      it "contentが10001文字以上" do
        @comment.content = 'a' * 10001
        @comment.valid?
        expect(@comment.errors.full_messages).to include("お知らせ内容は10000文字以内で入力してください")
      end
    end
  end
end
