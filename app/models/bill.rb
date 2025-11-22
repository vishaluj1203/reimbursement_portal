class Bill < ApplicationRecord
  belongs_to :submitted_by, class_name: "User", foreign_key: "submitted_by_id"
end
