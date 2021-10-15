class RelationshipsController < ApplicationController
  # https://qiita.com/mitsumitsu1128/items/e41e2ff37f143db81897

  before_action :set_user
  before_action :authenticate_user!

  def create
    following = current_user.follow(@user)
    if following.save
      @user.create_notification_follow!(current_user)
      flash[:success] = 'ユーザーをフォローしました'
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
    end
    redirect_to @user
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
    end
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
