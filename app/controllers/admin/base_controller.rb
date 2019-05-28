class Admin::BaseController < ApplicationController
  before_action :check_admin_permission

  def check_admin_permission
    unless current_user.try :admin?
      flash[:danger] = t "no_admin"
      redirect_to root_path
    end
  end
end
