class ActivitiesController < ApplicationController
  def index
    @activities = Activity.newest.by_activity_following(current_user.following).paginate page: params[:page],
      per_page: Settings.per_page

    @activities_user = Activity.newest.where(owner_id: current_user).paginate page: params[:page],
      per_page: Settings.per_page
  end
end
