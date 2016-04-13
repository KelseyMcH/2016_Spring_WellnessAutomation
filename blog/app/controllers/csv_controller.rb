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

			@activities = Action.joins(:activity,:user).where("actions.created_at > ?", (Date.today.at_beginning_of_month - 1.month)).select("activity_id, users.fname, users.lname, users.email, users.department_id, actions.user_id, actions.quantity, actions.created_at, activities.description, activities.value as points");
		    response.headers['Content-Type'] = 'text/csv'
		    response.headers['Content-Disposition'] = 'attachment; filename=activities.csv'    
		    render :template => "csv/index.csv.erb"
		end
	end
end
end

