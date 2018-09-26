class ApplicationController < ActionController::Base
  require 'will_paginate/array'
  check_authorization :unless => :devise_controller?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to root_url
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :password, :password_confirmation])
  end
end
