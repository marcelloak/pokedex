class FastMove < ApplicationRecord
  belongs_to :type

  has_many :pokemon_fast_moves
  has_many :pokemon_caught_timelines
end
