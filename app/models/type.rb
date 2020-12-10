class Type < ApplicationRecord
  has_many :type_interactions
  has_many :pokemons
  has_many :forms
  has_many :fast_moves
  has_many :charge_moves
  has_many :special_league_type_limits
end
