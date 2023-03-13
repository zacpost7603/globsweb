class UsersController < ApplicationController
  before_action :authenticate, except: [:new, :create]
  before_action :load_user, except: [:new, :create]
  
  def new
    if session[:user_hash]
      @user = User.new_from_hash session[:user_hash]
      @user.valid?
    else
      @user = User.new;
    end
  end
  def create
    if session[:user_hash]
      @user = User.new_from_hash session[:user_hash]
      @user.name = user_params[:name]
      @user.email = user_params[:email]
    else
      @user = User.new user_params
    end
    if @user.save
      login(@user)
      cookies[:auth_token] = @user.auth_token
      session[:user_hash] = nil
      redirect_to root_path, notice: "Welcome New User"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
  end 
  def edit
  end
  def update
    if @user.update user_params
      redirect_to @user, notice: "Account Updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    cookies.delete(:auth_token)
    logout
    @user.destroy
    redirect_to root_path, alert: "User was Deleted!"
  end
  
  private
  def load_user
    @user = User.find params[:id]
  end
  def user_params
    params.require(:user).permit(:name,:email,:password, :password_confirmation)
  end
end