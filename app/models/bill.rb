class Bill < ApplicationRecord
  belongs_to :submitted_by, class_name: "User", foreign_key: "submitted_by_id"

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :bill_type, presence: true, inclusion: { in: %w[food travel others] }

  before_validation :set_default_status

  private

  def set_default_status
    self.status ||= "pending"
  end
end
