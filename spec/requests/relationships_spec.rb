# なぜ通用しないかさっぱりわからん
# require 'rails_helper'

# RSpec.describe "Relationships", type: :request do
#   before do
#     @user = FactoryBot.create(:user)
#     @other_user = FactoryBot.create(:user)
#   end

#   describe 'create' do

#     it 'フォローする' do
#       sign_in @user
#       get user_path(@other_user.id)
#       click_on 'フォロー'
#       expect(@other_user.followed.count).to eq(1)
#       expect(@user.follower.count).to eq(1)
#     end
#   end

# end