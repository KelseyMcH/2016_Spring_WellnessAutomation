class AddGoalToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :goal, :integer, :default => 100, :null => false
  end
end
