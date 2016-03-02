class SessionsController < ApplicationController

 def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      if user.admin
        flash[:success] = "with great power comes great responsibiity"
        redirect_to '/activities'
      else
        flash[:success] = "logged in!"
        redirect_to user
      end
    else
    # If user's login doesn't work, send them back to the login form.
      flash[:danger] = "incorrect email or password"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end