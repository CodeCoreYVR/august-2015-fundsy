class Campaigns::TweetPublishingCampaign
  include Virtus.model

  attribute :campaign, Campaign
  attribute :user,     User

  def call
    begin
      client.update("Campaign #{campaign.title} is published!") if may_tweet?
    rescue => e
      # notify admin with detail from the exception object: e
      # you can use:
      # e.message
      # e.backtrace
      Rails.logger.info ">>>>>>>>>>>>>"
      Rails.logger.info e.message
      Rails.logger.info e.backtrace
      Rails.logger.info ">>>>>>>>>>>>>"
    end
  end
  # if you have delayed job set up, you can just do:
  # handle_asynchronously :call

  private

  def may_tweet?
    user.can_tweet?
  end

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret
      config.access_token        = user.twitter_consumer_token
      config.access_token_secret = user.twitter_consumer_secret
    end
  end


end
