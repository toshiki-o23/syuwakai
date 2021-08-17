class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :set_user_id, only: %i[evaluation following follower bookmarks]
  before_action :authenticate_user!, only: [:mypage]
  before_action :show_user, only: %i[show evaluation following follower]
  before_action :evaluation_number, only: %i[show evaluation following follower]

  def show
    @bookmark_events = @user.bookmark_events
    @user_events = UserEvent.where(user_id: current_user.id) if current_user
  end

  # ユーザーがログインしているとき自分のプロフィールを表示
  def mypage
    redirect_to user_path(current_user)
  end

  def evaluation
    @evaluations = Evaluation.where(event_id: Event.where(user_id: @user.id).ids)
  end

  def following
    @users = @user.followings
  end

  def follower
    @users = @user.followers
  end

  def bookmarks
    @events = @user.events
    @bookmark_events = @user.bookmark_events
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_id
    @user = User.find(params[:user_id])
  end

  def show_user
    @events = Event.where(user_id: @user.id)

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

  def evaluation_number
    # 評価機能
    @user_evaluation = 0
    Evaluation.where(event_id: Event.where(user_id: @user.id).ids).find_each do |evaluation|
      @user_evaluation += evaluation.evaluation
    end
    @user_evaluation /= Evaluation.where(event_id: Event.where(user_id: @user.id).ids).count if @user_evaluation != 0
  end
end
