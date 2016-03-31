class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
    	t.string :name
    	t.string :created_at
    	t.string :updated_at

      t.timestamps null: false
    end
  end
end
