class Admin::Devise::SessionsController < Devise::SessionsController

    # POST /resource/sign_in
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    resource.reset_authentication_token if resource.authentication_token.blank?
    respond_to do |format|
      format.html { respond_with resource, :location => redirect_location(resource_name, resource) }
      format.mobile { render :json=>resource.to_json(:only=>[:email,:authentication_token])}
    end
  end


  # GET /resource/sign_out
  def destroy
    signed_in = signed_in?(resource_name)
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :signed_out if signed_in

    # We actually need to hardcode this, as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.mobile {render :text => '', :status => :ok}
      format.html { redirect_to after_sign_out_path_for(resource_name) }
#      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
#      format.all do
#        method = "to_#{request_format}"
#        text = {}.respond_to?(method) ? {}.send(method) : ""
#        render :text => text, :status => :ok
#      end
    end
  end

end
