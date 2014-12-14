class FishSpot < ActiveRecord::Base
  belongs_to :spot
  belongs_to :fish

  class << self
    def save_relation(fish_name, spot_name)
      fish_spot = {}
      fish_spot[:spot_id] = Spot.find_by_name(spot_name).id
      fish_spot[:fish_id] = Fish.find_by_name(fish_name).id

      create(fish_spot) unless relation_exist?(fish_spot[:fish_id], fish_spot[:spot_id])
    end

    def relation_exist?(fish_id, spot_id)
      where(spot_id: spot_id).each do |fish_spot|
        return true if fish_spot.fish_id == fish_id
      end
      false
    end
  end
end
