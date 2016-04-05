module UsersHelper
  def getPoints user
    totalPoints = 0
    points = Action.where(:user_id => user.id)
    points.each do |p|
      action = Activity.find(p.activity_id)
      totalPoints += action.value
    end
    totalPoints
  end
end
