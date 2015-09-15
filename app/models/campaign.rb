class Campaign < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :goal, presence: true, numericality: {greater_than: 10}
  validates :description, presence: true
end
