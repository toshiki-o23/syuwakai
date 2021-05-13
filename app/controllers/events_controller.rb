class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    if @event.save
      redirect_to '/'
    end
  end

  def show
    @event = Event.find_by(params[:id])
  end
  private

    def event_params
      params.require(:event).permit(:title, :content)
    end
end
