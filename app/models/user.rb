class User < ActiveRecord::Base
  # attr_accessor :password
  has_secure_password

  has_many :campaign, dependent: :nullify

  validates :email, presence: true,
            format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
            unless: :from_omniauth?
  validates :first_name, presence: true
  validates :password_reset_token, uniqueness: true, allow_blank: true

  before_create :generate_api_key

  serialize :twitter_raw_data

  geocoded_by :address
  after_validation :geocode

  def from_omniauth?
    uid.present? && provider.present?
  end

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip
  end

  def self.find_from_omniauth(omniauth_data)
    User.where(provider: omniauth_data["provider"],
               uid:      omniauth_data["uid"]).first
  end

  def self.create_from_omniauth(omniauth_data)
    full_name = omniauth_data["info"]["name"].split
    User.create(uid:                      omniauth_data["uid"],
                provider:                 omniauth_data["provider"],
                first_name:               full_name[0],
                last_name:                full_name[1],
                twitter_consumer_token:   omniauth_data["credentials"]["token"],
                twitter_consumer_secret:  omniauth_data["credentials"]["secret"],
                twitter_raw_data:         omniauth_data,
                password:                 SecureRandom.hex(16)
                )
  end

  def password_reset_expired?
    Time.now > password_reset_expiry_date
  end

  def reset_token
    self.password_reset_token       = nil
    self.password_reset_expiry_date = nil
    save
  end

  def generate_password_reset_token
    begin
      self.password_reset_token = SecureRandom.urlsafe_base64(32)
    end while User.exists?(password_reset_token: self.password_reset_token)
    self.password_reset_expiry_date = Time.now + 3.days
    save
  end

  private

  def generate_api_key
    begin
      self.api_key = SecureRandom.urlsafe_base64(32)
    end while User.exists?(api_key: self.api_key)
  end


end
