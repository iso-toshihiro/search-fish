# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Spot.create(name: '大瀬崎', prefecture: '静岡')
Spot.create(name: '雲見', prefecture: '静岡')
Spot.create(name: '伊豆海洋公園', prefecture: '静岡')

Fish.create(name: 'ハナダイ')
Fish.create(name: 'オコゼ')
Fish.create(name: 'テングダイ')
Fish.create(name: 'クマノミ')
Fish.create(name: 'ウツボ')
Fish.create(name: 'ゴンズイ')

FishSpot.create(spot_id: 1, fish_id: 1)
FishSpot.create(spot_id: 1, fish_id: 5)
FishSpot.create(spot_id: 1, fish_id: 6)
FishSpot.create(spot_id: 2, fish_id: 1)
FishSpot.create(spot_id: 2, fish_id: 3)
FishSpot.create(spot_id: 2, fish_id: 5)
FishSpot.create(spot_id: 3, fish_id: 1)
FishSpot.create(spot_id: 3, fish_id: 2)
FishSpot.create(spot_id: 3, fish_id: 4)
FishSpot.create(spot_id: 3, fish_id: 5)
