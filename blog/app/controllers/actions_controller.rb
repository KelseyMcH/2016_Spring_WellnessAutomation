require 'date'

class ActionsController < ApplicationController

  def create
    @a= Activity.find(params[:activity_id])
    # if the activity requires a quantity calculate it from the parameters
    if @a.needsquantity
      @quantity = (params[:minutes].to_f / 15).round
    else
      @quantity = 1
    end
    #create action
     @action = Action.new(:user_id => params[:user_id], :activity_id => params[:activity_id], :quantity => @quantity)
     #find if the same action has been created in the last 24 hours
     @act = Action.find_by "activity_id = ? AND user_id = ? AND created_at > ?",params[:activity_id],params[:user_id],1.day.ago
     if @act == nil
      if @action.save
           flash[:success] = " You got #{@a.value * @quantity} points for #{@a.description} at #{@action.created_at}"
      else
           flash[:error] = "activity failed to save. please try again"
      end
    else
      flash[:error] = "you cannot log an activity more than once per day"
    end
    redirect_to '/activities'
  end

end
