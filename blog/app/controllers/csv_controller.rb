class CsvController < ApplicationController
#route for admin to download CSV action data
#querying actions because that's the name of the table that stores the relation between USER and ACTIVITY 
#format.csv because that's the file type
#render :tempalte=> csv/activities because it makes more sense to call the file activities
#SQL: return every action created since the first of last month.
def index




	respond_to do |format|

		format.csv do
			#no one else needs the CSV 
			redirect_to 'welcome/login' unless current_user and current_user.admin

			#get recent activities
			@activities = Action.joins(:activity,:user).where("actions.created_at > ?", (Date.today.beginning_of_week - 7.days)).select("activity_id, users.fname, users.lname, users.email, users.department_id, actions.user_id, actions.quantity, actions.created_at, activities.description, activities.value as points");
		   
		    response.headers['Content-Type'] = 'text/csv'
		    response.headers['Content-Disposition'] = 'attachment; filename=activities.csv'    
		    render :template => "csv/index.csv.erb"
		end
	end
end

def delete

	redirect_to 'welcome/login' unless current_user and current_user.admin

	#opposite: delete old activities
	Action.where("actions.created_at < ?", (Date.today.beginning_of_week)).destroy_all
	flash[:success] = "You have deleted all activities recorded before this week"
	redirect_to '/index'
end



end

