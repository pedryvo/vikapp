class Invite < ApplicationRecord
  belongs_to :admin
  belongs_to :company

  validates :admin_id, uniqueness: { scope: :company_id, message: "already has an invite for this company" }
end
