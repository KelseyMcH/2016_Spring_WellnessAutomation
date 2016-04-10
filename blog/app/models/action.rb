class Action < ActiveRecord::Base
	belongs_to :user
	belongs_to :activity

  def self.by_month(year,month)
    dt = DateTime.new(year,month)
    bom = dt.beginning_of_month
    eom = dt.end_of_month
    where("actions.created_at >= ? and actions.created_at <= ?", bom, eom)
  end

end
