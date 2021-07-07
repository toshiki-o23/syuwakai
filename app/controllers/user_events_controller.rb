class UserEventsController < ApplicationController
  def index
    @user_events = UserEvent.where(user_id: current_user.id, event_id: params[:id])
    @event = Event.where(params[:event_id])
  end

  def create
    @user_event = UserEvent.new(user_id: current_user.id, event_id: params[:event_id])
    if @user_event.save
      redirect_to event_user_event_path(@user_event)
    else
      render :show
    end
  end

  def show
    @user_event = UserEvent.find_by(user_id: current_user.id, event_id: params[:event_id])
    @event = Event.find(params[:event_id])
  end
end
