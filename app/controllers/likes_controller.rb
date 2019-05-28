class LikesController < ApplicationController
  authorize_resource
  before_action :load_book, only: %i(create destroy)
  before_action :load_unlike, only: :destroy

  def create
    unless user_like_book?
      @like = current_user.likes.create(book_id: @book.id)
      @like.create_activity :create, owner: current_user
      respond_to do |format|
        format.html{redirect_to request.referrer}
        format.js
      end
    end
  end

  def destroy
    if user_like_book?
      @unlike.destroy
      respond_to do |format|
        format.html{redirect_to request.referrer}
        format.js
      end
    else
      flash[:danger] = t "controller.likes.unlike_fail"
      redirect_to request.referrer
    end
  end

  private

  def user_like_book?
    Like.by_like_user(current_user.id, params[:book_id]).exists?
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t "controller.likes.load_like"
    redirect_to root_path
  end

  def load_unlike
    @unlike = current_user.likes.find_by(book_id: @book.id)
    return if @unlike
    flash[:danger] = t "controller.likes.load_unlike"
    redirect_to book_path(@book)
  end
end
