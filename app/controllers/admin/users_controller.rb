class Admin::UsersController < Admin::AdminsController
  before_action :find_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "create_success"
      redirect_to new_admin_user_path
    else
      render :new
    end
  end

  def index
    @users = User.paginate page: params[:page], per_page: Settings.user.number_per_page
  end

  def destroy
    Activity.destroy_user(@user, Settings.activities.followed, Settings.activities.unfollowed).destroy_all
    @user.destroy
    flash[:success] = t "user_delete_success"
    redirect_to admin_users_path
  end

  def edit

  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_success"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :fullname, :email, :admin,
      :password, :password_confirmation, :avatar
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = "#{t "no_user_found"} #{params[:id]}"
      redirect_to admin_root_path
    end
  end
end
