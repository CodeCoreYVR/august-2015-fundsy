class User < ActiveRecord::Base
  # attr_accessor :password
  has_secure_password

  validates :email, presence: true,
            format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, presence: true

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
