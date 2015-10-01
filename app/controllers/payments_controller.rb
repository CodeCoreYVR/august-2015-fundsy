class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @pledge = Pledge.find(params[:pledge_id])
  end

  def create
    @pledge = Pledge.find params[:pledge_id]

    customer = Stripe::Customer.create(
      :description => "Fund.sy Customer for #{current_user.id}",
      :source => params[:stripe_token] # obtained with Stripe.js
    )
    # Saving Stripe customer information
    current_user.stripe_customer_id  = customer.id
    current_user.stripe_card_last4   = customer.sources.data[0].last4
    current_user.stripe_card_type    = customer.sources.data[0].brand
    current_user.save

    charge = Stripe::Charge.create(
      :amount => @pledge.amount * 100,
      :currency => "cad",
      :customer => current_user.stripe_customer_id,
      :description => "Charge for Pledge: #{@pledge.id}"
    )
    @pledge.stripe_txn_id = charge.id
    @pledge.confirm
    @pledge.save

    redirect_to @pledge.campaign, notice: "Payment confirmed!"
  end
end
