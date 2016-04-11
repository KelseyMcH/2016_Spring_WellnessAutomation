class SessionsController < ApplicationController

 def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      if user.admin
        flash[:success] = "with great power comes great responsibiity"
        session[:user_id] = user.id
        redirect_to '/activities'
      else
        if user.email_confirmed
          session[:user_id] = user.id
          flash[:success] = "logged in!"
          redirect_to user
        else
          flash[:error] = 'Please activate your account by following the 
          instructions in the account confirmation email you received to proceed'
          redirect_to '/login'
        end
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