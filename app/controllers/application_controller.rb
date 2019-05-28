class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search_book
  protect_from_forgery with: :exception
  before_action :set_locale
  include PublicActivity::StoreController
  include SessionsHelper
  include BooksHelper
  include ApplicationHelper
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t ".pls_login"
    redirect_to new_user_session_path
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :address, :picture]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

  def search_book
    @q = Book.ransack params[:q]
    @books = @q.result.includes(:category, :likes, :reviews).newest
  end

  def require_log_in
    unless user_signed_in?
      flash[:danger] = t "controller.book.please_login"
      redirect_to new_user_session_path
    end
  end
end
