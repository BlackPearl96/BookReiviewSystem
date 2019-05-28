class Admin::CategoriesController < Admin::BaseController
  layout "admin"
  authorize_resource
  before_action :find_category, only: %i(update destroy)

  def index
    @search_categories = Category.ransack params[:q]
    @categories = @search_categories.result.sort_by_name.paginate page: params[:page],
     per_page: 10
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "controller.category.create_category"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def update
    @category = Category.restore(params[:id], recursive: true)
    if @category
      flash[:success] = t "controller.category.restore_category"
    else
      flash[:danger] = t "controller.category.nofound"
    end
    redirect_to admin_categories_path
  end

  def destroy
    if @category.destroy
      flash[:success] = t "controller.category.temporary_category"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "un_delete"
      redirect_to admin_root_path
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :parent_id
  end

  def find_category
    @category = Category.find_by_id params[:id]
    return if @category
    flash[:danger] = t "fail"
    redirect_to admin_root_path
  end
end
