class Admin::WordsController < Admin::AdminsController
  before_action :find_word, only: [:edit, :update]

  def create
    @word = Word.new word_params
    @category = Category.find params[:word][:category_id]
    if @word.save
      flash[:success] = t "create_success"
      redirect_to :back
    else
      flash[:danger] = t "flash_error"
      redirect_to :back
    end
  end

  def destroy
    Word.find(params[:id]).destroy
    flash[:success] = t "word_delete_success"
    redirect_to :back
  end

  def edit

  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "update_success"
      redirect_to [:admin, @word.category]
    else
      flash[:danger] = t "flash_error"
      redirect_to :back
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
