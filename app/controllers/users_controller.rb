class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "User created and signed in!"
      redirect_to products_path #, notice: "User created!"
    else
      flash[:alert] = "Something went wrong!!"
      render :new
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
