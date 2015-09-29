class Api::V1::CampaignsController < ApplicationController
  before_action :authorize

  def index
    @campaigns = Campaign.includes(:user, :comments).published.
                  order(:created_at).references(:user, :comments).decorate
  end

  def show
    @campaign = Campaign.find params[:id]
    render json: @campaign
  end

  private

  def authorize
    @user = User.find_by_api_key params[:api_key]
    head :unauthorized unless @user
  end

end
