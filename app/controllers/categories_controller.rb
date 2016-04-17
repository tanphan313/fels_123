class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]

  def show
    @words = @category.words.paginate page: params[:page],
      per_page: Settings.word.number_per_page
  end

  def index
    @categories = Category.all.paginate page: params[:page],
      per_page: Settings.category.number_per_page
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "no_category_found", id: params[:id]
      redirect_to root_path
    end
  end
end
