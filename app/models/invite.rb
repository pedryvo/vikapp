class Invite < ApplicationRecord
  belongs_to :admin
  belongs_to :company

  validates :admin_id, uniqueness: { scope: :company_id, message: "already has an invite for this company" }

  scope :active_in_month, ->(month) {
    end_date = Date.new(Date.today.year, month, -1).end_of_day
    where("deactivated_at IS NULL OR deactivated_at > ?", end_date)
  }
end
