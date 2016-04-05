class UsersController < ApplicationController

  def new 
    @user = User.new
    @departments = Department.all
    render 'users/new'
  end

  def create

    @user = User.new(user_params)

    domain = @user.email.slice(/@.*/)
    #JUST TESTING THE EMAIL REGISTRATION

    if domain != "@lifecarealliance.org"
      flash[:error] = "email is not a lifecarealliance address. "
      render :action => 'new'
    else
      if @user.save
        session[:user_id] = @user.id
        UserMailer.welcome_email(@user, @user.password).deliver
        flash[:success] = "welcome! click add points to log your activities."
        redirect_to @user
      else
      render :action => 'new'
      end
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @department = Department.find(1)
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :department, :email, :password, :password_confirmation)
  end

  def change
  end

end
