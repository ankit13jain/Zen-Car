class ApplicationController < ActionController::Base
  before_action :authenticate_customer!
  protect_from_forgery with: :exception

  # This should probably be abstracted to ApplicationController
  def authorize_admin
    return if current_customer.admin?
    redirect_to root_path, alert: 'Admins only!' unless current_customer and current_customer.admin?
  end

  def authorize_superadmin
    return if current_ustomer.superadmin?
    redirect_to root_path, alert: 'SuperAdmins only!'
  end

end