class RemoveDepartmentFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :department, :string
    add_column :users, :department_id, :int
  end
end
