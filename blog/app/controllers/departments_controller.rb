require 'Date'

class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.create(activity_params)
    redirect_to action: "index"
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    redirect_to action: "index"
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])

    if (@department.update(activity_params))
      redirect_to action: "index"
    else
      render 'edit'
    end
  end

  def show
    @department = Department.find(params[:id])
    @scoresbyuser = Action.joins(:activity, [user: :department]).by_month(Date.today.year,Date.today.month).group(:user_id).select("user_id as id, fname, lname, email, sum(quantity*value) as points").where("department_id = " + params[:id])
  end

  private
  def activity_params
      params.require(:department).permit(:name)
  end
end
