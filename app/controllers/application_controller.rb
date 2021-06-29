class ApplicationController < ActionController::Base
  # deviseにおけるログイン時の保存条件
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def configure_permitted_parameters
    # sign_up時ストロングパラメータ追加
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email introduce encrypted_password image])
    # アカウント編集時ストロングパラメータ追加
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email introduce encrypted_password image])
  end

  def set_search
    @q = Event.ransack(params[:q])
    @search_events = @q.result
  end
end
