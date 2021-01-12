class Family < ApplicationRecord
  belongs_to :generation
  
  has_many :pokemons
  has_many :candies
end
