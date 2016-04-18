require 'date'

class UsersController < ApplicationController

  #get actions as json 
  def useractions
    respond_to do |format| 
      @actions = Action.joins(:activity).where("User_id = ? AND actions.created_at > ?", params[:id], (Date.today.beginning_of_week)).select("activity_id, user_id, actions.quantity, actions.created_at, activities.description, activities.value as points")
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
    if domain.length < 1 # != "@lifecarealliance.org"
      flash[:error] = "email is not a lifecarealliance address. "
      redirect_to(:back)
    elsif params[:password] != params[:password_confirmation]
      flash[:error] = "passwords don't match"
      redirect_to(:back)
    elsif User.exists?( :email => params[:email]) 
      flash[:error] = "email is taken"
      redirect_to(:back)
    elsif @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Please confirm your email address to continue"
      redirect_to root_url
    else
      flash[:error] = "user is already created"
      redirect_to(:back)
    end
  end

  def index
    @users = User.all
    @activities = Action.joins(:activity,:user).where("actions.created_at > ?", (Date.today.beginning_of_week)).select("activity_id, users.fname, users.lname, users.email, users.department_id, actions.user_id, actions.quantity, actions.created_at, activities.description, activities.value as points")
    @scoresbyuser = Hash.new
    @scoresbydept = Hash.new

    @activities.each do |a|
      if @scoresbyuser[a.email]
         @scoresbyuser[a.email]["pts"] += (a.points * a.quantity)
      else
        user = Hash.new
        user["pts"] = (a.points * a.quantity)
        user["dept"] = Department.find(a.department_id).name
        user["name"] = a.fname + " " + a.lname
        user["id"] = User.find(a.user_id)
        user["guy"] = a.user_id
        @scoresbyuser[a.email] = user
      end

      if @scoresbydept[a.department_id]
        @scoresbydept[a.department_id]["pts"] += (a.points * a.quantity)
      else
        dept = Hash.new
        dept["pts"] = (a.points * a.quantity)
        dept["name"] = Department.find(a.department_id).name
        result = User.where("department_id = ? AND email_confirmed = ?", a.department_id, true).select("email")
        if result
         dept["members"] = result.length
        else
          dept["members"] = 0
        end
        @scoresbydept[a.department_id] = dept
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @actions = Action.joins(:activity).where("User_id = ? AND actions.created_at > ?", params[:id], (Date.today.beginning_of_week)).select("activity_id, user_id, actions.quantity, actions.created_at, activities.description, activities.value as points")
    @score = 0

    @actions.each do |a|
       @score += (a.points * a.quantity)
    end

    @department = Department.find(@user.department_id)

  end

 def destroy
    redirect_to 'welcome/index' unless current_user.admin
    @user = User.find(params[:id])
    @user.destroy
    flash["success"] = "this user can always recreate their account if they are still an employee!"
    redirect_to action: "index"
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :goal, :department_id, :email, :password, :password_confirmation, :confirm_token)
  end

  def change
  end

end

