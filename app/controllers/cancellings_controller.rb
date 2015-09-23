class CancellingsController < ApplicationController
  before_action :authenticate_user!

  def create
    campaign = Campaign.find params[:campaign_id]
    if campaign.cancel!
      redirect_to campaign, notice: "Campaign Cancelled"
    else
      redirect_to campaign, alert: "Can't cancel campaign, it may be already cancelled"
    end
  end
end
