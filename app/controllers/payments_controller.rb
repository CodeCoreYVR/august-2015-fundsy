class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @pledge = Pledge.find(params[:pledge_id])
  end

  def create
    @pledge = Pledge.find params[:pledge_id]

    service = Payments::CreatePayment.new(pledge:       @pledge,
                                          user:         current_user,
                                          stripe_token: params[:stripe_token])
    if service.call
      redirect_to @pledge.campaign, notice: "Payment confirmed!"
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end
end
