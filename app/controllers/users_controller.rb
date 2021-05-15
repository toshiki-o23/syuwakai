class UsersController < ApplicationController
  def show
    @user = current_user
    @events = @user.events
  end
end
