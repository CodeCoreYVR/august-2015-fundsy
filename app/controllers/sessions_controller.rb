class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email params[:email]
    session[:user_id] = @user.id
    redirect_to root_path, notice: "Logged in!"
  end
end