module ApplicationHelper
  def full_title page_title
    base_title = I18n.t("title")
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def select_roles
    User.roles.keys.map{|role| [role, role]}
  end
end
