class Admin::AdminsController < ApplicationController
  before_action :admin_user

  def home
  end

  private
  def admin_user
    redirect_to root_path unless is_admin?
  end
end
