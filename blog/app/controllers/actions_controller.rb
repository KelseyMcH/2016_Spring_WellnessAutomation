require 'date'

class ActionsController < ApplicationController

  def create
  	 @action = Action.new(:user_id => params[:user_id], :activity_id => params[:activity_id])

     act = Action.find_by "activity_id = ? AND user_id = ? AND created_at > ?",params[:activity_id],params[:user_id],1.day.ago
     if act == nil
      if @action.save
           @a= Activity.find(params[:activity_id])
           @user = current_user
           oldpts = @user.points
           @user.update_attribute(:points, oldpts+@a.value)
           @user.save
           flash[:success] = " You got #{@a.value} points for #{@a.description} at #{@action.created_at}"

      else
           flash[:error] = "activity failed to save. please try again"
      end
    else
      flash[:error] = "you cannot log an activity more than once per day"
    end
    redirect_to "/activities#index"
  end
end
