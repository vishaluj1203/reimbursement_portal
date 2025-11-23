class EmployeesController < ApplicationController
  before_action :require_login
  before_action :require_admin
  before_action :set_employee, only: [:show, :update, :destroy]

  def index
    @employees = User.all
    render json: @employees, status: :ok
  end

  def show
    render json: @employee, status: :ok
  end

  def create
    @employee = User.new(employee_params)
    if @employee.save
      render json: @employee, status: :created
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee, status: :ok
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    render json: { message: "Employee deleted" }, status: :ok
  end

  private

  def set_employee
    @employee = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Employee not found" }, status: :not_found
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :password, :password_confirmation, :role, :department_id)
  end
end
