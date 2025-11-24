class EmployeesController < ApplicationController
  before_action :require_login
  before_action :require_admin
  before_action :set_employee, only: [:show, :update, :destroy]

  def index
    employees = User.employee.order(:id)
    render json: employees, status: :ok
  end

  def show
    render json: @employee, status: :ok
  end

  def create
    @employee = User.new(employee_params)
    @employee.employee!
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
    @employee = User.employee.find_by(id: params[:id])
    return render json: { error: "Employee not found" }, status: :not_found unless @employee
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :designation, :department_id, :password, :password_confirmation)
  end
end
