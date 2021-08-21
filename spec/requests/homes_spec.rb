# require 'rails_helper'

# RSpec.describe "root", type: :request do
#   describe "トップページ (GET /)" do
#     context "未ログイン" do
#       it "トップページ" do
#         get root_path
#         expect(response).to have_http_status "200"
#       end
#     end
#     context "ログイン済み" do
#       before do
#         @user = FactoryBot.create(:user)
#         sign_in @user
#       end
#       it "トップページ" do
#         get root_path
#         expect(response).to have_http_status "200"
#       end
#     end
#   end
# end
