class AddDepartmentRefToUsers < ActiveRecord::Migration
  def change
  	add_reference :users, :department_id, index: true, foreign_key: true
  end
end
