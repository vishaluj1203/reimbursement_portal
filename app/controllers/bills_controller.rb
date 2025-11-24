class BillsController < ApplicationController
  before_action :require_login
  before_action :require_employee, only: [ :index, :create ]
  before_action :require_admin, only: [ :all, :approve, :reject ]
  before_action :set_bill, only: [ :approve, :reject ]

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

  def all
    bills = Bill.includes(:submitted_by).order(created_at: :desc)
    render json: bills, status: :ok
  end

  def approve
    @bill.approved!
    render json: @bill, status: :ok
  end

  def reject
    @bill.rejected!
    render json: @bill, status: :ok
  end

  private

  def bill_params
    params.require(:bill).permit(:amount, :bill_type)
  end

  def require_employee
    render json: { error: "Forbidden" }, status: :forbidden if current_user.admin?
  end

  def set_bill
    @bill = Bill.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Bill not found" }, status: :not_found
  end
end
