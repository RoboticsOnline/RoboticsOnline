class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_permitted_parameters, if: :devise_controller?
   before_filter :set_last_request_at 

  protect_from_forgery with: :exception
  protected

    def after_sign_in_path_for(resource)
        if resource.is_a?(User)
           root_path
        else
            super
        end
    end 
    def set_last_request_at 
      current_user.update_attribute(:last_request_at, Time.now) if user_signed_in? 
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) << :username
    end
    protect_from_forgery
    def resource_name
    	   :user
    end

    def admin?
        @admin = false
        if not current_user.nil?
            Admin.all.each do |a|
                if a.user_id == current_user.id
                    @admin = true
                end
            end
        end
        @admin 
    end
	   def resource
	       @resource ||= User.new
	   end

	   def devise_mapping
		  @devise_mapping ||= Devise.mappings[:user]
	   end

    helper_method :resource, :resource_name, :devise_mapping
end
