class ApplicationController < ActionController::Base
<<<<<<< HEAD
  require 'will_paginate/array'
  check_authorization :unless => :devise_controller?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :password, :password_confirmation])
  end
=======
>>>>>>> 507e1839bd0bd2bd5110eb622a62489feade8e2f
end
