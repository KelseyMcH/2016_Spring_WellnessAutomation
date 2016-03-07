class AddActivityRefToActions < ActiveRecord::Migration
  def change
    add_reference :actions, :activity_id, index: true, foreign_key: true
  end
end
