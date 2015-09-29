class Campaigns::CreateCampaign
  # attr_accessor :user
  # attr_accessor :params
  #
  # def initialize(attributes)
  #   @user = attributes[:user]
  #   @params = attributes[:params]
  # end

  include Virtus.model

  attribute :user,     User
  attribute :params,   Hash
  attribute :campaign, Campaign

  # aim to have a single public method for your service objects
  # to comply with the Single Responsibility Principle (SRP)
  def call
    @campaign      = Campaign.new params
    @campaign.user = user
    @campaign.save
  end


end
