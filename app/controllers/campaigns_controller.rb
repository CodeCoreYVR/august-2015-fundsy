class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new campaign_params
    @campaign.user = current_user
    if @campaign.save
      redirect_to campaign_path(@campaign), notice: "Campaign created!"
    else
      render :new
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :goal, :end_date)
  end

end
