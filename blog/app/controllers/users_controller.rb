require 'date'

class UsersController < ApplicationController

  #get actions as json 
  def useractions
    respond_to do |format| 
      @actions = Action.where("User_id = ? AND created_at > ?", params[:id], (Date.today-31.days))
      format.json { render :json => @actions }
    end
  end

  def goal
      @user = current_user
      @user.update_attribute(:goal, params[:goal])
      render nothing: true
  end

  def new 
    @user = User.new
    @departments = Department.all
    render 'users/new'
  end

  def create

    @user = User.new(user_params)

    domain = @user.email.slice(/@.*/)
    #JUST TESTING THE EMAIL REGISTRATION

    #if domain != "@lifecarealliance.org"
     # flash[:error] = "email is not a lifecarealliance address. "
      #render :action => 'new'
    #else
      if @user.save
        UserMailer.registration_confirmation(@user).deliver
        flash[:success] = "Please confirm your email address to continue"
        redirect_to root_url
      else
        flash[:error] = "user is already created"
      render :action => 'new'
      end
    #end
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
    @departments = Department.all
    #all actions from user within last month
    actions = Action.where("User_id = ? AND created_at > ?", params[:id], (Date.today-31.days))
    @points = 0
    actions.each do |a|
      activity = Activity.find(a.activity_id)
      @points += activity.value
    end
    @points
    #sam
    @score = Action.joins(:activity, [user: :department]).by_month(Date.today.year,Date.today.month).where("user_id = " + @user.id.to_s).select("sum(quantity*value) as points")

  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :goal, :department_id, :email, :password, :password_confirmation, :confirm_token)
  end

  def change
  end

end

