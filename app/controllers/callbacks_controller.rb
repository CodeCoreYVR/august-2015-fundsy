class CallbacksController < ApplicationController

  def index
    omniauth_data = request.env['omniauth.auth']
    user          = User.find_from_omniauth(omniauth_data)
    unless user
      user = User.create_from_omniauth(omniauth_data)
    end
    sign_in(user)
    redirect_to root_path, notice: "Thank you signing in!"
  end
end
