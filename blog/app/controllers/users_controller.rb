class UsersController < ApplicationController
  def new 
    @user = User.new
    @departments = Department.all
    render 'users/new'
  end

  def create
    user = User.new(user_params)

    domain = user.email.slice(/@.*/)
    puts domain

    if domain == '@lifecarealliance.org' && user.save
      session[:user_id] = user.id
      flash[:success] = "good job you created your account!"
      redirect_to user
    else
      flash[:warning] = "something is wrong with this form"
      redirect_to '/signup'
      #GIVE BACK ERROR? FLASH MESSAGE
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @department = Department.find(@user.department_id)
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :department_id, :email, :password, :password_confirmation)
  end

  def change
  end

end
