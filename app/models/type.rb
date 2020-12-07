class Type < ApplicationRecord
  has_many :pokemons
  has_many :type_interactions
  has_many :forms
end
