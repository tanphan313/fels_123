class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = current_user.get_activity_items params
    else
      @categories = Category.all.paginate page: params[:page],
        per_page: Settings.category.number_per_page
    end
  end
end
