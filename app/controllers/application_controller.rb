class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :prepare_for_mobile

  private

    def set_mobile_device_format?
      return false unless request.params[:format].blank?
      if session[:mobile_param]
        session[:mobile_param] == "1"
      else
        mobile_device?
      end
    end

    def mobile_device?
      request.user_agent =~ /Mobile|webOS/
    end

    helper_method :mobile_device?

    def prepare_for_mobile
      session[:mobile_param] = params[:mobile] if params[:mobile]
      request.format = :mobile if set_mobile_device_format?
    end


end
