class SessionsController < ApplicationController
  def new
  end
  def create
    @user = User.where(email: params[:email]).first
    if @user && @user.authenticate(params[:password])
      #login(@user)
      if params[:remember_me]
        cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token
      end
      redirect_url = session[:protected_page] ? session[:protected_page] : root_path
      session[:protected_page] = nil
      redirect_to redirect_url, notice: "Login Successful"
    else
      redirect_to login_path, alert: "Incorrect Email or Password"
    end
  rescue BCrypt::Errors::InvalidHash
    redirect_to login_path, alert: "Invalid password, did you sign up with Github?"
  end
  def destroy
    cookies.delete(:auth_token)
    logout
    redirect_to root_path, notice: "Logged Out"
  end
end
