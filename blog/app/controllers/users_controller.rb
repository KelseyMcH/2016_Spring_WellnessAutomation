class UsersController < ApplicationController
  def new 
    @user = User.new
    render 'users/new'
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user
    else
      redirect_to '/signup'
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :department, :email, :password, :password_confirmation)
  end

end