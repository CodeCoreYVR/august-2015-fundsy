class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    service = Users::CreateUser.new(params: user_params)
    if service.call
      sign_in(service.user)
      redirect_to root_path, notice: "Account created!"
    else
      @user = service.user
      flash[:alert] = "Did not create"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :address)
  end
end
