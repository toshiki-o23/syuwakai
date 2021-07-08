class UserEventsController < ApplicationController
  def index
    @user_events = UserEvent.where(user_id: current_user.id)
    @events = Event.all
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
  end

  private

  def user_event_params
    params.permit(:user_id, :event_id).merge(user_id: current_user.id)
  end
end
