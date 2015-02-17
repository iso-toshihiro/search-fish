class Spot < ActiveRecord::Base
  has_many :spots_fishes
  has_many :fishes, through: :spots_fishes
end
