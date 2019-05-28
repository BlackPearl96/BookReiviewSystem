class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :load_user, except: :index
  before_action :load_follow, :load_unfollow, only: %i(following followers show)

  def index
    @users = User.sort_by_name.paginate page: params[:page],
      per_page: Settings.controllers.user.index_page
    respond_to do |format|
      format.html
      format.csv {send_data @users.to_csv}
      format.xls {send_data @users.to_csv(col_sep: "\t")}
    end
  end

  def show; end

  def following
    @title = t "controller.user.following"
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.per_page
    render :show_follow
  end

  def followers
    @title = t "controller.user.followers"
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.per_page
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :phone,
      :address, :password, :password_confirmation, :role, :picture
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "controller.user.find_user_error"
    redirect_to root_path
  end

  # def correct_user
  #   redirect_to root_path unless current_user?(@user)
  # end

  # def admin_user
  #   redirect_to root_path unless current_user.admin?
  # end

  def load_follow
    @follow = current_user.active_relationships.build
  end

  def load_unfollow
    @unfollow = current_user.active_relationships.find_by(followed_id: @user.id)
  end
end
