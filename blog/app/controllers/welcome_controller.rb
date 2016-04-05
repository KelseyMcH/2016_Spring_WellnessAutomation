class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to current_user
    end
  end

  def stats
  end

  def profile
  end

  def recover_password
  end

  def guide
  end
end
