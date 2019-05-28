class Admin::BooksController < Admin::BaseController
  layout "admin"
  authorize_resource
  before_action :load_book, except: %i(index new create)
  before_action :load_suggest, only: :create

  def index
    @search_book = Book.ransack params[:q]
    @books = @search_book.result.newest.by_category(params[:category_id]).paginate page:
      params[:page], per_page: Settings.per_page
  end

  def statistical; end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    @suggest.accepted! if @suggest
    if @book.save
      flash[:success] = t "controller.book.create_book"
      redirect_to admin_books_path
    else
      render :new
    end
  rescue Exception
    flash[:notice] = t "controller.user.errors"
    redirect_to request.referrer
  end

  def edit; end

  def update
    if @book.update_attributes(book_params)
      flash[:success] = t "controller.book.update_book"
      redirect_to admin_books_path
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "controller.book.delete_book"
      redirect_to admin_books_path
    else
      flash[:danger] = t "controller.book.delete_fail"
      redirect_to admin_root_path
    end
  end

  private

  def book_params
    params.require(:book).permit :title,
      :publish_date, :content, :description, :author, :publisher,
      :rate_points, :number_pages, :category_id, :book_img
  end

  def load_book
    @book = Book.find_by_id params[:id]
    return if @book
    flash[:danger] = t "messenger"
    redirect_to admin_book_path
  end

  def load_suggest
    @suggest = Suggest.find_by id: params[:book][:suggest_id]
    return @suggest
    flash[:danger] = t "messenger"
    redirect_to admin_root_path
  end
end
