class Booking < ApplicationRecord
  belongs_to :nanny
  belongs_to :user

  STATUS = ["pending", "accepted", "declined"]

  validates :status, inclusion: { in: STATUS }

  def duration
  end
end
