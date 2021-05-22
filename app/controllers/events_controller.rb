class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

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
      @event.save
      redirect_to event_path(@event.id)
  end

  def show
  end

  def edit
  end

  def update
    @event.update(event_params)
    redirect_to event_path
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :content, :image).merge(user_id: current_user.id)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
