class Booking < ApplicationRecord
  belongs_to :nanny
  belongs_to :user

  def duration
    return nil if start_time.nil? || end_time.nil?
    ((end_time - start_time) / 3600/24).round
  end
end
