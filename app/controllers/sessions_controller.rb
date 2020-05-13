class SessionsController < ApplicationController

  #GET /login
  def new
  end

  #POST /login
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password]) #userがnilでないかつ、パスワードが正しい場合
      log_in user
      remember user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  #DELETE /logout
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
