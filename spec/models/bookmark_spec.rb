require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'アソシエーションのテスト' do
    context 'モデルとの関係' do
      it 'User' do
        expect(Bookmark.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it 'Event' do
        expect(Bookmark.reflect_on_association(:event).macro).to eq :belongs_to
      end
    end
  end
end
