class Booking < ApplicationRecord
  belongs_to :nanny
  belongs_to :user
end
