class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!, only: [:mypage]

  def show
    @events = @user.events
    @bookmark_events = @user.bookmark_events

    return unless user_signed_in?

    @current_user_entry = DmEntry.where(user_id: current_user.id)
    @user_entry = DmEntry.where(user_id: @user.id)

    return if @user.id == current_user.id

    @current_user_entry.each do |cu|
      @user_entry.each do |u|
        if cu.dm_room_id == u.dm_room_id
          @is_room = true
          @room_id = cu.dm_room_id
        end
      end
    end

    return if @is_room

    @room = DmRoom.new
    @entry = DmEntry.new
  end

  # ユーザーがログインしているとき自分のプロフィールを表示
  def mypage
    redirect_to user_path(current_user)
  end

  def following
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  def follower
    @user = User.find(params[:user_id])
    @users = @user.followers
  end

  def bookmarks
    @user = User.find(params[:user_id])
    @events = @user.events
    @bookmark_events = @user.bookmark_events
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
