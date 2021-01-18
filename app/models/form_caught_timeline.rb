class FormCaughtTimeline < ApplicationRecord
  enum pvp: [ "", :Great, :Ultra, :Master, :Little ]

  belongs_to :current_form, :class_name => 'Form'
  belongs_to :target_form, :class_name => 'Form'
  belongs_to :fast_move
  belongs_to :first_charge_move, :class_name => 'ChargeMove'
  belongs_to :second_charge_move, :class_name => 'ChargeMove'
  belongs_to :original_owner, :class_name => 'Player'
  belongs_to :current_owner, :class_name => 'Player'
  belongs_to :current_level, :class_name => 'PokemonLevel'
  belongs_to :target_level, :class_name => 'PokemonLevel'
end
