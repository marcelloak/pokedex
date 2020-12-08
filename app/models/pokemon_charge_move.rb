class PokemonChargeMove < ApplicationRecord
  belongs_to :charge_move
  belongs_to :pokemon
end
