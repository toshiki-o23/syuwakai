class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all.order(:id)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
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
    params.permit(:name)
  end
end
