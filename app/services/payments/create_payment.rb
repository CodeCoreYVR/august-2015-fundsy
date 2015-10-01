class Payments::CreatePayment

  include Virtus.model

  attribute :pledge,       Pledge
  attribute :user,         User
  attribute :stripe_token, String

  def call
    create_customer && charge_customer
  end

  private

  def create_customer
    Payments::CreateCustomer.new(user: user, stripe_token: stripe_token).call
  end

  def charge_customer
    begin
      charge = Stripe::Charge.create(charge_information_hash)
      pledge.stripe_txn_id = charge.id
      pledge.confirm
      pledge.save!
    rescue => e
      # Notify admin with error
      false
    end
  end

  def charge_information_hash
    {
      :amount => pledge.amount * 100,
      :currency => "cad",
      :customer => user.stripe_customer_id,
      :description => "Charge for Pledge: #{pledge.id}"
    }
  end

end
