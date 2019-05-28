class RelationshipsController < ApplicationController
  before_action :require_log_in
  before_action :load_relationship, only: :destroy

  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow(@user)
      @unfollow = current_user.active_relationships.find_by(followed_id: @user.id)
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "error"
      redirect_to current_user
    end
  end

  def destroy
    if @relationship.followed
      @user = @relationship.followed
      current_user.unfollow @user
      @follow = current_user.active_relationships.build
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "error"
      redirect_to current_user
    end
  end

  private

  def load_relationship
    @relationship = Relationship.find_by id: params[:id]
    return if @relationship
    flash[:danger] = t "no_data"
    redirect_to current_user
  end
end
