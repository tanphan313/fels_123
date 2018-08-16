class PasswordsController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :validate_old_password, only: [:update]

  def edit

  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = "#{t "no_user_found"} #{params[:id]}"
      redirect_to root_path
    end
  end

  def validate_old_password
    unless @user.authenticate(params[:user][:old_password])
      @user.errors.add(:old_password, t("password_not_match"))
      render :edit
    end
  end
end
