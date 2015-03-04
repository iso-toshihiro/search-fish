class FishSpot < ActiveRecord::Base
  belongs_to :spot
  belongs_to :fish

  class << self
    def save_relation(fish_name, spot_name)
      fish_spot = {}
      fish_spot[:spot_id] = Spot.find_by_tmp_name(spot_name).id
      fish_spot[:fish_id] = Fish.find_by_name(fish_name).id

      unless relation_exist?(fish_spot[:fish_id], fish_spot[:spot_id])
        @fish_spot = create(fish_spot)
        p "New relation fish_spot_id:#{@fish_spot.id} #{spot_name} - #{fish_name}"
      end
    end

    def relation_exist?(fish_id, spot_id)
      where(spot_id: spot_id, fish_id: fish_id).present?
    end
  end
end
