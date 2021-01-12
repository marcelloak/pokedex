class PokemonLevel < ApplicationRecord
  has_many :pokemon_caught_timelines
  has_many :form_caught_timelines
  has_many :costume_caught_timelines
end
