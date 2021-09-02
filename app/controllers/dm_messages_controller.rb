class DmMessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    if DmEntry.where(user_id: current_user.id, dm_room_id: params[:dm_room_id])
      @message = DmMessage.create(params.require(:dm_message).permit(:user_id, :content,
                                                                     :dm_room_id).merge(user_id: current_user.id))
      redirect_to "/dm_rooms/#{@message.dm_room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
