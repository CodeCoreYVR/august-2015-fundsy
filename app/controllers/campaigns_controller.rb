class CampaignsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_campaign, only: [:show, :update, :destroy, :edit]

  def index
    @campaigns = Campaign.order(:created_at)
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
  end

  def edit
    unless current_user == @campaign.user
      redirect_to root_path, alert: "Access denied!"
    end
  end

  def update
    if current_user == @campaign.user
      if @campaign.update(campaign_params)
        redirect_to @campaign, notice: "Campaign Created!"
      else
        render :edit
      end
    else
      redirect_to root_path, alert: "Access denied!"
    end
  end

  def destroy
    if current_user == @campaign.user
      @campaign.destroy
      redirect_to campaigns_path, notice: "Campaign deleted!"
    else
      redirect_to root_path, alert: "Access denied!"
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :goal, :end_date)
  end

  def find_campaign
    @campaign = Campaign.find params[:id]
  end

end
