class User < ActiveRecord::Base
  # attr_accessor :password
  has_secure_password

  has_many :campaign, dependent: :nullify

  validates :email, presence: true,
            format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, presence: true
  validates :password_reset_token, uniqueness: true, allow_blank: true

  geocoded_by :address
  after_validation :geocode

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip
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

end
