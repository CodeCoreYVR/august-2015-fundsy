class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def new
    @campaign = Campaign.new
  end
end
