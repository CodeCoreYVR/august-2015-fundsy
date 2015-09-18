class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def index
    @campaigns = Campaign.all
  end

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

  def show
    @campaign = Campaign.find params[:id]
  end

  def edit
    @campaign = Campaign.find params[:id]
    unless current_user == @campaign.user
      redirect_to root_path, alert: "Access denied!"
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :goal, :end_date)
  end

end
