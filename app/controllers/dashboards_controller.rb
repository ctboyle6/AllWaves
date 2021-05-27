class DashboardsController < ApplicationController
  def show
    @user_spots = current_user.user_spots
  end
end
