class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all.order(id: :DESC)
  end

  def show
    @room = Room.find(params[:id])
    if Room.where(room_id: @room.id)
      @messages = @room.messages.order(id: :DESC)
      @message = Message.new
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to room_path(@room.id)
    else
      render 'new'
    end
  end

  private

  def room_params
    params.permit(:name, :content)
  end
end
