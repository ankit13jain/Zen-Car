class ApplicationController < ActionController::Base
  before_action :authenticate_customer!
  protect_from_forgery with: :exception

  # This should probably be abstracted to ApplicationController
  def authorize_admin
    return unless !current_customer.admin?
    redirect_to root_path, alert: 'Admins only!'
  end

  def authorize_superadmin
    return unless !current_ustomer.superadmin?
    redirect_to root_path, alert: 'SuperAdmins only!'
  end

end