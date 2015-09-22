class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email params[:email]
    if @user
      @user.generate_password_reset_token
      UserMailer.send_password_reset_instructions(@user).deliver_now
    end
  end

  def edit
    @user = User.find_by_password_reset_token params[:id]
    if @user && @user.password_reset_expired?
      redirect_to new_password_reset_path, alert: "Password reset expired"
    elsif @user.password_reset_token
      render
    else
      redirect_to new_password_reset_path, alert: "Password reset not found"
    end
  end

  def update
    @user = User.find_by_password_reset_token params[:id]
    if @user && @user.password_reset_expired?
      redirect_to new_password_reset_path, alert: "Password reset expired"
    elsif @user.password_reset_token
      if @user.update user_params
        @user.reset_token
        redirect_to new_session_path, notice: "Password reset successfully"
      else
        render :edit
      end
    else
      redirect_to new_password_reset_path, alert: "Password reset not found"
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
