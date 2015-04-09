# encoding: utf-8
class SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
    sign_in_and_redirect(resource_name, resource)
  end

  def sign_in_and_redirect(resource_or_scope, resource = nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    respond_to do |format|
      format.html {redirect_to request.referer}
    end
  end

  def failure
    respond_to do |format|
      format.html {redirect_to request.referer}
    end
  end
end
