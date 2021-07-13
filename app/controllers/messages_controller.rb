class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    if Room.where(room_id: params[:room_id])
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
