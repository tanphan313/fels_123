class Admin::CategoriesController < Admin::AdminsController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "create_success"
      redirect_to :back
    else
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :title, :description
  end
end
