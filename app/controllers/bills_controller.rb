class BillsController < ApplicationController
  before_action :require_login
  before_action :require_employee, only: [ :create, :index ]

  def index
    bills = current_user.bills.order(created_at: :desc)
    render json: bills, status: :ok
  end

  def create
    bill = current_user.bills.new(bill_params)

    if bill.save
      render json: bill, status: :created
    else
      render json: { errors: bill.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:amount, :bill_type)
  end

  def require_employee
    render json: { error: "Forbidden" }, status: :forbidden if admin?
  end
end
