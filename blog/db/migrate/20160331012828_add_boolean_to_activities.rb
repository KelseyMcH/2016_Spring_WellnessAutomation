class AddBooleanToActivities < ActiveRecord::Migration
  def change
  	  add_column :activities, :needsquantity, :boolean, :default => false
  end
end
