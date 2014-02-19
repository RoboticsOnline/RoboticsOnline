class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      user_path
    else
      super
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
	protect_from_forgery
	  def resource_name
		:user
	  end

	  def resource
		@resource ||= User.new
	  end

	  def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	  end
	helper_method :resource, :resource_name, :devise_mapping
end
