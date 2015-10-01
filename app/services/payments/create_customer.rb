class Payments::CreateCustomer
  include Virtus.model

  attribute :user,         User
  attribute :stripe_token, String

  def call
    begin
      customer = Stripe::Customer.create customer_information_hash
      update_user_information(customer)
    # rescue Stripe::StripeError => e
    rescue => e
      # You can notify admin for exmple here.
      # you have access to: e.message (main exception message)
      # and e.backtrace (full backtrace array of lines leading to exception)
      false
    end
  end

  private

  def update_user_information(customer)
    # Saving Stripe customer information
    user.stripe_customer_id  = customer.id
    user.stripe_card_last4   = customer.sources.data[0].last4
    user.stripe_card_type    = customer.sources.data[0].brand
    user.save!
  end

  def customer_information_hash
    {
      :description => "Fund.sy Customer for #{user.id}",
      :source => stripe_token
    }
  end

end
