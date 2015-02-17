class Fish < ActiveRecord::Base
  has_many :spots_fishes
  has_many :spots, through: :spots_fishes
end
