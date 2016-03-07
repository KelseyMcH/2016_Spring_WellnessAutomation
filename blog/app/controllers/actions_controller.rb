class ActionsController < ApplicationController

  def create
  	 @action = Action.new(:user_id => params[:user_id], :activity_id => params[:activity_id])
  	 if @action.save
       @a= Activity.find(params[:activity_id])
       flash[:success] = " You got #{@a.value} points for #{@a.description} at #{@action.created_at}"
  	else
       flash[:error] = ":-) epic fail"
   end
   	redirect_to '/activities'
  end
end
