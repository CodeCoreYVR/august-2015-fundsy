class Pledge < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign

  include AASM

  aasm whiny_transitions: false do
    state :pending, initial: true
    state :confirmed
    state :failed
    state :refunded

    event :confirm do
      transitions from: :pending, to: :confirmed
    end

    event :fail do
      transitions from: [:pending, :refunded], to: :failed
    end

    event :refund do
      transitions from: :confirmed, to: :refunded
    end

  end

end
