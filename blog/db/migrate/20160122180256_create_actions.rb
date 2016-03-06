class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|	
    add_reference :actions, :user, index: true, foreign_key: true
    add_reference :actions, :activity, index: true, foreign_key: true
    
      t.timestamps null: false
    end
  end
end
