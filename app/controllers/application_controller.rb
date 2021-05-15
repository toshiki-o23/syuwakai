class ApplicationController < ActionController::Base

  # deviseにおけるログイン時の保存条件
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # sign_up時ストロングパラメータ追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :encrypted_password,  :image])
    # アカウント編集時ストロングパラメータ追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :encrypted_password, :image])
  end

end
