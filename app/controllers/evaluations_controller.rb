class EvaluationsController < ApplicationController
  before_action :authenticate_user!
  def create
    @evaluation = Evaluation.new(evaluation_params)
    @evaluation.user_id = current_user.id
    @event = Event.find(@evaluation.event_id)
    @user_event = UserEvent.find_by(user_id: current_user, event_id: @event.id)
    if @evaluation.save
      redirect_to event_user_event_path(@user_event, @event), notice: '評価しました！再評価はできません'
    else
      redirect_to event_user_event_path(@user_event, @event), alert: '評価できません'
    end
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:comment, :evaluation, :event_id, :user_id)
  end
end
