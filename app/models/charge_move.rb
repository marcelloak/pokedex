class ChargeMove < ApplicationRecord
  has_many :pokemon_charge_moves
  has_many :pokemon_caught_timelines
end
