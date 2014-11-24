class FishSpot < ActiveRecord::Base
  belongs_to :spot
  belongs_to :fish
end
