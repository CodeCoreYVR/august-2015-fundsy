class NearbyCampaignsController < ApplicationController
  before_action :authenticate_user!

  def index
    user_coordinates = [current_user.latitude, current_user.longitude]
    @campaigns       = Campaign.near(user_coordinates, 40, units: :km)
  end
end
