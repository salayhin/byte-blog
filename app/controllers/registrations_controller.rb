# encoding: utf-8
class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_to do |format|
          @success = true
          format.js
          format.html { redirect_to request.referer, notice: 'You sign up successfully' }
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_to do |format|
          @success = true
          format.js
          format.html { redirect_to request.referer, notice: 'You sign up successfully' }
        end
      end
    else
      clean_up_passwords resource
      respond_to do |format|
        @success = false
        format.html do
          redirect_to action: 'new'
        end
      end
    end
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end
end
