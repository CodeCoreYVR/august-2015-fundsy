class Reward < ActiveRecord::Base
  belongs_to :campaign

  validates :amount, presence: true,
                     numericality: {greater_than_or_equal_to: 1}
  validates :description, presence: true
end
