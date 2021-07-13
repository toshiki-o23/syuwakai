class DmRoomsController < ApplicationController
  before_action :authenticate_user!
  def create
    @room = DmRoom.create
    @entry1 = DmEntry.create(dm_room_id: @room.id, user_id: current_user.id)
    @entry2 = DmEntry.create(params.require(:dm_entry).permit(:user_id, :dm_room_id).merge(dm_room_id: @room.id))
    redirect_to "/dm_rooms/#{@room.id}"
  end

  def show
    @room = DmRoom.find(params[:id])
    if DmEntry.where(user_id: current_user.id, dm_room_id: @room.id)
      @messages = @room.dm_messages
      @message = DmMessage.new
      @entries = @room.dm_entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
