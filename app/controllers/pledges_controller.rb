class PledgesController < ApplicationController
  before_action :authenticate_user!

  def create
    @campaign        = Campaign.find(params[:campaign_id]).decorate
    @pledge          = Pledge.new pledge_params
    @pledge.user     = current_user
    @pledge.campaign = @campaign
    if @pledge.save
      redirect_to new_pledge_payment_path(@pledge), notice: "Thanks for pledging, make a payment"
    else
      render "/campaigns/show"
    end
  end

  private

  def pledge_params
    params.require(:pledge).permit(:amount)
  end

end
