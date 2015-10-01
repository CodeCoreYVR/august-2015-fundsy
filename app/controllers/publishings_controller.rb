class PublishingsController < ApplicationController
  before_action :authenticate_user!

  def create
    campaign = Campaign.find params[:campaign_id]
    if campaign.publish!
      Campaigns::TweetPublishingCampaign.
                    new(campaign: campaign, user: current_user).call
      redirect_to campaign, notice: "Campaign Published"
    else
      redirect_to campaign, alert: "Can't publish campaign, it may be already published"
    end
  end

end
