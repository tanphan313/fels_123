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

  def index
    @categories = Category.all
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = t "category_delete_success"
    redirect_to :back
  end

  private
  def category_params
    params.require(:category).permit :title, :description
  end
end
