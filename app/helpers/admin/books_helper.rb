module Admin::BooksHelper
  def load_categories_for_selectbox
    @categories = Category.sort_by_name.map{|c| [c.name, c.id]}
  end
end
