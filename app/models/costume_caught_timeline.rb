class CostumeCaughtTimeline < ApplicationRecord
  belongs_to :current_costume, :class_name => 'Costume'
  belongs_to :target_costume, :class_name => 'Costume'
  belongs_to :fast_move
  belongs_to :first_charge_move, :class_name => 'ChargeMove'
  belongs_to :second_charge_move, :class_name => 'ChargeMove'
  belongs_to :original_owner, :class_name => 'Player'
  belongs_to :current_owner, :class_name => 'Player'
  belongs_to :current_level, :class_name => 'PokemonLevel'
  belongs_to :target_level, :class_name => 'PokemonLevel'
end
