class Booking < ApplicationRecord
  belongs_to :nanny
  belongs_to :user

  def duration
  end
end
