# coding: utf-8
class DivingSpotsController < ApplicationController
  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
    @fish = @spot.fish
    @groups = get_grops(@fish)
  end

  def search
    all_ids = Spot.all.map { |spot| spot.id }
    display_ids = Spot.where('name LIKE ?', "%#{params[:keyword]}%").map { |spot| spot.id }
    render json: { all_ids: all_ids, display_ids: display_ids }
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

  private

  def get_grops(fish)
    grops = fish.map { |f| f.group }
    grops.uniq
  end
end
