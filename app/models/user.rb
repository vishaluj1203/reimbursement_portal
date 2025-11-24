class User < ApplicationRecord
  belongs_to :department
  has_secure_password

  enum :role, {
    employee: 0,
    admin: 1
  }
end
