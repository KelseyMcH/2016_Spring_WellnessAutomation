require 'date'

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
    @month = 4
    @year = 2016
    @scoresbydept = Action.joins(:activity, [user: :department]).by_month(@year,@month).group(:department_id).select("department_id as id, departments.name as name, sum(quantity*value) as points")
    @scoresbyuser = Action.joins(:activity, [user: :department]).by_month(@year,@month).group(:user_id).select("user_id as id, department_id as did, fname, lname, email, departments.name as dname, sum(quantity*value) as points")
  end

  def show
    @user = User.find(params[:id])
    @department = Department.find(@user.department_id)
    @score = Action.joins(:activity, [user: :department]).by_month(Date.today.year,Date.today.month).where("user_id = " + @user.id.to_s).select("sum(quantity*value) as points")
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :department_id, :email, :password, :password_confirmation)
  end

  def change
  end

end

