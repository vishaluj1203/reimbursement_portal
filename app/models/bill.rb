class Bill < ApplicationRecord
  belongs_to :submitted_by, class_name: "User", foreign_key: "submitted_by_id"

  enum bill_type: { food: "food", travel: "travel", others: "others" }

  enum status: { pending: "pending", approved: "approved", rejected: "rejected" }, _default: "pending"

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :bill_type, presence: true
  validates :status, presence: true
end
