class Admin::CategoriesController < Admin::AdminsController
  before_action :find_category, only: [:show, :edit, :update]

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

  def show
    @word = Word.new
    Settings.word.number_of_answers.times do
      @word_answer = @word.word_answers.build
    end
    @words = @category.words.paginate page: params[:page],
      per_page: Settings.word.number_per_page
  end

  def edit

  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_success"
      redirect_to edit_admin_category_path @category
    else
      flash[:danger] = t "flash_error"
      render :edit
    end
  end

  private
  def category_params
    params.require(:category).permit :title, :description
  end

  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = "#{t "no_category_found"} #{params[:id]}"
      redirect_to admin_categories_path
    end
  end
end
