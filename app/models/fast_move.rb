class FastMove < ApplicationRecord
  has_many :pokemon_fast_moves
  has_many :pokemon_caught_timelines
end
