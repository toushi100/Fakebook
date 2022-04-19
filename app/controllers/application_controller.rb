class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    around_action :switch_locale
    
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name , :profile_picture , :phone_number ])
  end

  def switch_locale(&action)
    I18n.default_locale = params[:locale] || I18n.default_locale
    I18n.with_locale(I18n.default_locale, &action)
  end

end
