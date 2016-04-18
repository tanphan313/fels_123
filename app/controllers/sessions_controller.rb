class SessionsController < ApplicationController
  skip_before_action :store_location_app

  def new

  end

  def create
    user = User.find_by email: params[:session][:email]
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "#{t "log_in_success"} #{user.fullname}"
      remember_user user if params[:session][:remember_me]
      login user
      redirect_back_or user
    else
      flash[:danger] = t "invalid_input"
      redirect_to :back
    end
  end

  def destroy
    logout
    flash[:success] = t "log_out_success"
    redirect_to root_path
  end
end
