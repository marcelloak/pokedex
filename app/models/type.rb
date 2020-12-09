class Type < ApplicationRecord
  has_many :pokemons
  has_many :type_interactions
  has_many :forms
  has_many :special_league_type_limits
end
