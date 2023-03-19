class Panel < ApplicationRecord
  belongs_to :commissioning_report
  
  validates :identifier, presence: true,
                         uniqueness: true,
                         format: { with: /\A[0-9]{6}\z/i, message: "Identifier is not valid" }
end
