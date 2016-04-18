class StaticPagesController < ApplicationController
  def home
    unless logged_in?
      @categories = Category.all.paginate page: params[:page],
        per_page: Settings.category.number_per_page
    end
  end
end
