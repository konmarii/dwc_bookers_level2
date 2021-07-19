class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :show]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :password])
    devise_parameter_sanitizer.permit(:sign_in,keys:[:name, :password])
    devise_parameter_sanitizer.permit(:account_update,keys:[:name,:email])
  end
  
  #アカウント登録後のリダイレクト先
  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  #アカウント編集後のリダイレクト先
  def after_update_path_for(resource)
    user_path(resource)
  end
  
  #ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end 
  
  #ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
     root_path
  end
  
end
