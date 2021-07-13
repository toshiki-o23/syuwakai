require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.build(:event)
  end

  describe '新規投稿' do
    context '新規投稿が可能の場合' do
      it "内容に問題ない場合" do
        expect(@event).to be_valid  
      end
      it "titleが30文字以下" do
        @event.title = 'a' * 30
        expect(@event).to be_valid  
      end
      it "imageが空" do
        @event.image = ''
        expect(@event).to be_valid
      end
    end

    context "新規投稿が不可の場合" do
      it "titleが空" do
        @event.title = ''
        @event.valid?
        expect(@event.errors.full_messages).to include("タイトルを入力してください")
      end
      it "titleが31文字以上" do
        @event.title = 'a' * 31
        @event.valid?
        expect(@event.errors.full_messages).to include("タイトルは30文字以内で入力してください")
      end
      it "contentが空" do
        @event.content = ''
        @event.valid?
        expect(@event.errors.full_messages).to include("内容を入力してください")
      end
      it "contentが1001文字以上" do
        @event.content = 'a' * 1001
        @event.valid?
        expect(@event.errors.full_messages).to include("内容は1000文字以内で入力してください")
      end
    end
  end

  describe 'アソシエーション' do
    context 'モデルとの関係' do
      it 'User' do
        expect(Event.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it 'Bookmark' do
        expect(Event.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end
  end
end
