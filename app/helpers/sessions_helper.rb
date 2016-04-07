module SessionsHelper
  def login user
    session[:current_user_id] = user.id
  end

  def remember_user user
    user.remember
    cookies.permanent.signed[:current_user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if user_id = session[:current_user_id]
      @current_user = User.find user_id
    elsif user_id = cookies.signed[:current_user_id]
      user = User.find user_id
      if user && user.authenticated?(:remember, cookies[:remember_token])
        login user
        @current_user = user
      end
    else
      @current_user = nil
    end
  end

  def logged_in?
    current_user.present?
  end

  def forget user
    user.forget
    cookies.delete :current_user_id
    cookies.delete :remember_token
  end

  def logout
    forget current_user
    session.delete :current_user_id
  end

  def current_user? user
    current_user == user
  end

  def is_admin?
    current_user.admin
  end
end
