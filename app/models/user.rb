class User < ApplicationRecord
  belongs_to :department
  has_many :bills, foreign_key: :submitted_by_id, inverse_of: :submitted_by

  has_secure_password

  enum :role, {
    employee: 0,
    admin: 1
  }
end
