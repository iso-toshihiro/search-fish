# coding: utf-8
class DivingSpotsController < ApplicationController
  def index
    @spots = Spot.all
    @spot_list_height = calculate_height(@spots.size, 3, 30)
  end

  def show
    @spot = Spot.find(params[:id])
    @fish = @spot.fish
    @groups = get_grops(@fish)
    @fish_list_height = calculate_height(@fish.size, 3, 220, 97)
  end

  def search
    spots = case params[:abroad]
            when 'true'  then Spot.where(abroad: true)
            when 'false' then Spot.where(abroad: false)
            when 'NULL'  then Spot
            end

    all_ids     =  Spot.all.map { |spot| spot.id }
    display_ids =  spots.where('tmp_name   LIKE ?', "%#{params[:keyword]}%").map { |spot| spot.id }
    display_ids += spots.where('name       LIKE ?', "%#{params[:keyword]}%").map { |spot| spot.id }
    display_ids += spots.where('furigana   LIKE ?', "%#{params[:keyword]}%").map { |spot| spot.id }
    display_ids += spots.where('alphabet   LIKE ?', "%#{params[:keyword]}%").map { |spot| spot.id }
    display_ids += spots.where('country    LIKE ?', "%#{params[:keyword]}%").map { |spot| spot.id }
    display_ids += spots.where('prefecture LIKE ?', "%#{params[:keyword]}%").map { |spot| spot.id }
    display_ids += spots.where('area       LIKE ?', "%#{params[:keyword]}%").map { |spot| spot.id }

    render json: { all_ids: all_ids, display_ids: display_ids.uniq }
  end

  def selecte
    fish = Spot.find(params[:id]).fish
    all_ids = fish.map { |f| f.id }

    display_ids = if params[:group] == 'すべて'
                    all_ids
                  else
                    fish.where(group: params[:group]).map { |f| f.id }
                  end
    render json: { all_ids: all_ids, display_ids: display_ids }
  end

  def coordinates
    spots = Spot.all.map do |spot|
      {id: spot.id, lat: spot.latitude, lng: spot.longitude, name: spot.name}
    end
    render json: { spots: spots }
  end

  private

  def get_grops(fish)
    grops = fish.map { |f| f.group }
    grops.uniq
  end

  def calculate_height(number_of_item, number_of_column, height_par_line, offset = 0)
    number_of_line = (number_of_item.to_f / number_of_column).ceil
    number_of_line * height_par_line + offset
  end
end
