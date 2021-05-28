class UserSpotsController < ApplicationController

    def index
    @user_spots = UserSpot.all
  end
  
  def new
    @user_spot = UserSpot.new
    @spot = Spot.find(params[:spot_id])
  end

  def create
    @user_spot = UserSpot.new()
    @spot = Spot.find(params[:spot_id])
    @user_id = current_user.id
    @user_spot.spot_id = @spot.id
    @user_spot.user_id = @user_id
    if @user_spot.save
      flash[:alert] = "UserSpot successfully created"
      redirect_to user_root_path
    else
      flash[:alert] = "Something went wrong"
      render 'new'
    end
  end
  
  def destroy
    @user_spot = UserSpot.find(params[:id])
    if @user_spot.destroy
      flash[:alert]  = 'UserSpot was successfully deleted.'
      redirect_to "/"
    else
      flash[:alert]  = 'Something went wrong'
      redirect_to "/"
    end
  end

end
