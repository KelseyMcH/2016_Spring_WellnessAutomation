class AddQuantityToActions < ActiveRecord::Migration
  def change
  	add_column :actions, :quantity, :integer, :default => 0
  end
end
