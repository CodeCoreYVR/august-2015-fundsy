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

  has_many :comments, as: :commentable, dependent: :destroy

  # address is a field in our database in this case. We expect the user to
  # provide the full address location of the campaign
  geocoded_by :address               # can also be an IP address
  # Ideally you will make the geocoding happen in the background
  # because it connects to a third party service. So you shouldn't have the
  # web request waitng for that.
  after_validation :geocode


  validates :title, presence: true, uniqueness: true
  validates :goal, presence: true, numericality: {greater_than: 10}
  validates :description, presence: true
  validates :rewards, presence: true

  scope :published, lambda { where(aasm_state: :published) }
  # def self.published
  #   where(aasm_state: :published)
  # end

  include AASM

  # the whiny_transitions option when assigned to false it makes it so AASM
  # doesn't throw an exception when you try to do an invalid transition such
  # as trying to call .fund when the campaign is in draft state
  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :funded
    state :unfunded
    state :cancelled
    state :archived

    event :publish do
      transitions from: :draft, to: :published
    end

    event :fund do
      transitions from: :published, to: :funded
    end

    event :expire do
      transitions from: :published, to: :unfunded
    end

    event :archive do
      transitions from: [:funded, :unfunded, :published], to: :archived
    end

    event :cancel do
      transitions from: :published, to: :cancelled
    end

  end


end
