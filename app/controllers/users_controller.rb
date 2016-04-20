class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "sign_up_success"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @activities = @user.activities.order(created_at: :DESC).paginate page: params[:page],
      per_page: Settings.activities.number_per_page
  end

  def edit

  end

  def index
    @users = User.all.paginate page: params[:page], per_page: Settings.user.number_per_page
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
    params.require(:user).permit :fullname, :email, :password,
      :password_confirmation, :avatar
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
end
