class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :store_location_app

  private
  def store_location_app
    store_location unless logged_in?
  end

  def logged_in_user
    redirect_to login_path unless logged_in?
  end
end
