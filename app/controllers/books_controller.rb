class BooksController < ApplicationController
  authorize_resource
  before_action :load_book, :build_like, :build_review, only: %i(show)
  before_action :book_by_category, except: %i(index)
  before_action :book_by_like, only: %i(searchlike)
  impressionist :actions=>[:show,:index]

  def index
    @books = Book.newest
    @book_news = Book.newest.paginate page: params[:page],
      per_page: Settings.controllers.book.index_page
  end

  def show
    impressionist(@book)
    @reviews = @book.reviews.newest_review.paginate page: params[:page],
      per_page: Settings.controllers.book.index_page
    return unless @reviews
    @book.rate_points = @book.reviews.average(:rate)
  end

  def find; end

  def search; end

  def searchlike
    @searchlike = Book.by_like_book(@book_like)
  end

  private

  def book_params
    params.require(:book).permit :title, :content, :description, :author,
      :publisher, :rate_points, :number_pages, :category_id, :book_img
  end

  def build_like
    @like = @book.likes.new
  end

  def build_review
    @review = @book.reviews.build
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t "controller.no_data_book"
    redirect_to books_path
  end

  def book_by_category
    @q = Book.ransack params[:q]
    @books = @q.result.by_category(params[:category]).limit Settings.models.limit
  end

  def book_by_like
    @book_like = current_user.likes.pluck(:book_id)
  end
end
