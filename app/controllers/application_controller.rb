class ApplicationController < ActionController::Base
  before_action :authenticate_customer!
  protect_from_forgery with: :exception
end