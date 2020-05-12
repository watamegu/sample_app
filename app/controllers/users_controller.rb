class UsersController < ApplicationController

  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end

  #GET /users/new
  def new
    @user = User.new
  end

  #POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # => redirect_to user_path(@user)
      #GET "users/#{@user.id}"
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end