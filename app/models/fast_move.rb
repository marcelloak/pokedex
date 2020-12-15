class FastMove < ApplicationRecord
  belongs_to :type

  has_many :pokemon_fast_moves
  has_many :pokemon_caught_timelines
  has_many :form_caught_timelines
  has_many :costume_caught_timelines
end
