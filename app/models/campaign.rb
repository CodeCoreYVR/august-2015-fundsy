class Campaign < ActiveRecord::Base
  belongs_to :user

  has_many :rewards, dependent: :destroy
  # this allows you to pass in special parameters rewards_attributes which
  # can contain one or more rewards to be automatically created right after
  # creating the campaign
  # reject_if: :all_blank option will make it so if you pass it a set of blank
  # attributes, it will just ignore that set instead of attempting to create it
  # so it won't fail validations with the reward model
  accepts_nested_attributes_for :rewards, reject_if: :all_blank,
                                allow_destroy: true

  validates :title, presence: true, uniqueness: true
  validates :goal, presence: true, numericality: {greater_than: 10}
  validates :description, presence: true
  validates :rewards, presence: true

end
