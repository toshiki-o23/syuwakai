class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!, only: [:mypage]

  def show
    @events = @user.events
    @bookmark_events = @user.bookmark_events
  end

  # ユーザーがログインしているとき自分のプロフィールを表示
  def mypage
    redirect_to user_path(current_user)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end