class EventsController < ApplicationController
  before_action :baria_user, only: %i[edit destroy]
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all
  end

  def new
    if user_signed_in?
      @event = Event.new
    else
      flash[:notice] = '投稿できません!
      ログインしてください!'
      redirect_to events_path
    end
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to event_path(@event.id)
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    @event.update(event_params)
    redirect_to event_path
  end

  def destroy
    @user = User.find(@event.user_id)
    @event.destroy
    redirect_to user_path(@user.id)
  end

  private

  def event_params
    params.require(:event).permit(:title, :content, :image).merge(user_id: current_user.id)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  # 投稿者以外投稿を編集削除しないように
  # https://asalworld.com/1534/
  def baria_user
    return unless Event.find(params[:id]).user_id == current_user.id do;
      flash[:notice] = '権限がありません'
      redirect_to user_path(@user.id)
    end
  end
end
