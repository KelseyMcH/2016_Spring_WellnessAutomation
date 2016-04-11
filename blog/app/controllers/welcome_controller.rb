class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to current_user
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:confirm_token])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to '/login'
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to '/login'
    end
  end

  def profile
  end

  def recover_password
  end

  def guide
  end
end
