class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @event = Event.find(params[:event_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      @event.create_notification_comment!(current_user, @comment.id)
      redirect_to event_user_event_path(id: @event.id)
    else
      render template: 'events/index'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, event_id: @event.id)
  end
end
