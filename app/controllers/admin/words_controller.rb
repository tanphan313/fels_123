class Admin::WordsController < Admin::AdminsController
  before_action :find_word, only: [:edit, :update]

  def create
    @word = Word.new word_params
    @category = Category.find params[:word][:category_id]
    @words = @category.words.paginate page: params[:page],
      per_page: Settings.word.number_per_page
    if @word.save
      flash[:success] = t "create_success"
      redirect_to [:admin, @category]
    else
      render "admin/categories/show", id: @category.id
    end
  end

  def show

  end

  def destroy
    Word.find(params[:id]).destroy
    flash[:success] = t "word_delete_success"
    redirect_to :back
  end

  def edit

  end

  def update
    @word.validate_word word_params
    if @word.errors.count > 0
      render :edit
    else
      if @word.update_attributes word_params
        flash[:success] = t "update_success"
        redirect_to [:admin, @word.category]
      else
        render :edit
      end
    end
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      word_answers_attributes: [:id, :content, :correct, :_destroy]
  end

  def find_word
    @word = Word.find_by id: params[:id]
    unless @word
      flash[:danger] = "#{t "no_word_found"} #{params[:id]}"
      redirect_to admin_root_path
    end
  end
end
