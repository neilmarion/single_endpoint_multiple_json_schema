class Guest < ActiveRecord::Base
  has_many :reservations
  has_many :guest_phone_numbers
end
