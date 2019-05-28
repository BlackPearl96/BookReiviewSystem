class Admin::SuggestsController < ApplicationController
  layout "admin"
  before_action :load_suggest, :build_book, except: :index

  def index
    @suggests = Suggest.newest.paginate page:
      params[:page], per_page: Settings.per_page
  end

  def update
    @suggest.status = params[:value]
    if @suggest.save
      flash[:success] = t "controller.suggests.rejected"
    else
      flash[:danger] = t "controller.suggests.fail"
    end
    redirect_to admin_suggests_path
  end

  def edit; end

  private

  def load_suggest
    @suggest = Suggest.find_by id: params[:id]
    return @suggest
    flash[:danger] = t "controller.suggests.loadsuggest"
    redirect_to admin_root_path
  end

  def build_book
    @book = Book.new
  end
end
