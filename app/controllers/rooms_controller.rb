class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all.order(:id)
    @room = Room.new
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  def create
    @room = Room.new
    if @room.save
      redirect_to room_path(@room.id)
    else
      render 'new'
    end
  end
end
