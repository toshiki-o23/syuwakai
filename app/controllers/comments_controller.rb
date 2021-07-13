class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @event = Event.find(params[:event_id])
    @comment.event_id = @event.id
    if @comment.save
      @event.create_notification_comment!(current_user, @comment.id)
      redirect_to event_user_event_path(id: @event.id)
    else
      render template: 'events/index'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :event_id)
  end
end
