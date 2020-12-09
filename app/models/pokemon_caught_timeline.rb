class PokemonCaughtTimeline < ApplicationRecord
  belongs_to :pokemon
  belongs_to :fast_move
  belongs_to :first_charge_move, :class_name => 'ChargeMove'
  belongs_to :second_charge_move, :class_name => 'ChargeMove'
  belongs_to :original_owner, :class_name => 'Player'
  belongs_to :current_owner, :class_name => 'Player'
end
