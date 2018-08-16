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
    session.delete :forwarding_url
  end

  def current_user? user
    current_user == user
  end

  def is_admin?
    current_user.admin
  end

  def avatar_empty? user
    user.avatar.blank?
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
  end

  def get_activity_lesson activity
    activity.user.lessons.find activity.target_id
  end

  def get_activity_category activity
    activity.user.lessons.find(activity.target_id).category
  end

  def get_activity_target_user activity
    User.find activity.target_id
  end

  def link_activity_user activity
    link_to activity.user.fullname, activity.user
  end

  def link_activity_lesson activity
    link_to t("lesson_title"), [get_activity_category(activity), get_activity_lesson(activity)]
  end

  def link_activity_category activity
    link_to get_activity_category(activity).title, get_activity_category(activity)
  end

  def link_activity_target_user activity
    link_to get_activity_target_user(activity).fullname, get_activity_target_user(activity)
  end

  def get_link_activity activity
    if activity.action_type == Settings.activities.learned
      t "learned_lesson_html",
        user_name: link_activity_user(activity),
        word_count: get_activity_lesson(activity).words.count,
        lesson: link_activity_lesson(activity),
        category: link_activity_category(activity)
    elsif activity.action_type == Settings.activities.followed
      t "followed_user_html",
        user_name: link_activity_user(activity),
        user: link_activity_target_user(activity)
    else
      t "unfollowed_user_html",
        user_name: link_activity_user(activity),
        user: link_activity_target_user(activity)
    end
  end

  def show_avatar user
    if avatar_empty? user
      image_tag "user.png"
    else
      image_tag user.avatar
    end
  end
end
