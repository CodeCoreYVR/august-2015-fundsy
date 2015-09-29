class Users::CreateUser

  include Virtus.model

  attribute :params, Hash
  attribute :user,   User

  def call
    @user = User.new params
    if @user.save
      send_mail
      true
    else
      false
    end
  end

  private

  def send_mail
    # send welcome email in here
  end

end
