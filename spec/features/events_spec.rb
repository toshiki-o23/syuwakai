# require 'rails_helper'

# RSpec.feature "Events", type: :feature do
#   scenario '投稿可能' do
#     user = FactoryBot.build(:user)
#     sign_up_as user

#     expect(page).to have_content('イベント投稿')

#     expect {
#       click_link('イベント投稿')
#       expect(current_path).to eq new_event_path
#       fill_in 'event_title', with: '手話勉強会'
#       fill_in 'event_content', with: '手話を勉強しよう！'
#       find('input[type="submit"]').click
#     }.to change(Event, :count).by(1)

#     expect(page).to have_content('手話勉強会')
#   end
# end
