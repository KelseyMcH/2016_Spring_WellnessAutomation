class AddUserRefToActions < ActiveRecord::Migration
  def change
    add_reference :actions, :user, index: true, foreign_key: true
  end
end
