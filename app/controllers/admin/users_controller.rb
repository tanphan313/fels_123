class Admin::UsersController < Admin::AdminsController
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

  private
  def user_params
    params.require(:user).permit :fullname, :email, :admin,
      :password, :password_confirmation
  end
end
