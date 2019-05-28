module Admin::CategoriesHelper
  def load_categories
    Category.sort_by_name
  end
end
