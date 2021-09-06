class UserEventsController < ApplicationController
  after_action :chat, only: %i[show]

  def index
    require 'date'
    @user_events = UserEvent.where(user_id: current_user.id)
    @events = Event.all.includes(%i[user tagmaps tags])
    @finish_events = Event.joins(:user_events).where('finish_time < ?',
                                                     DateTime.now).where(user_events: { user_id: current_user.id })
  end

  def create
    @event = Event.find_by(params[:id])
    @user_event = UserEvent.new(user_event_params)
    if @user_event.save
      redirect_to event_user_event_path(@user_event, id: @user_event.event_id)
    else
      render :show
    end
  end

  def show
    @event = Event.find(params[:id])
    @comment = Comment.new
    @comments = @event.comments
    # イベント詳細
    @user_event = UserEvent.find_by(user_id: current_user, event_id: params[:id])
    # 参加する人数やユーザー表示
    @user_events = UserEvent.where(event_id: params[:id])
    @evaluation = Evaluation.new
    # 評価済みなら評価フォームを表示しない
    @evaluations = Evaluation.where(user_id: current_user.id, event_id: @event.id)
  end

  private

  def user_event_params
    params.permit(:user_id, :event_id).merge(user_id: current_user.id)
  end

  def chat
    @current_user_entry = DmEntry.where(user_id: current_user.id)
    @user_entry = DmEntry.where(user_id: @event.user_id)

    return if @event.user_id == current_user.id

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
end
