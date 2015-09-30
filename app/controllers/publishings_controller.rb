class PublishingsController < ApplicationController
  before_action :authenticate_user!

  def create
    campaign = Campaign.find params[:campaign_id]
    if campaign.publish!

      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = Rails.application.secrets.twitter_api_key
        config.consumer_secret     = Rails.application.secrets.twitter_api_secret
        config.access_token        = current_user.twitter_consumer_token
        config.access_token_secret = current_user.twitter_consumer_secret
      end

      client.update("Campaign #{campaign.title} is published!")

      redirect_to campaign, notice: "Campaign Published"
    else
      redirect_to campaign, alert: "Can't publish campaign, it may be already published"
    end
  end

end
