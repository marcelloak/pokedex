class Form < ApplicationRecord
  belongs_to :primary_type, :class_name => 'Type'
  belongs_to :secondary_type, :class_name => 'Type', optional: true
  belongs_to :evolves_from, :class_name => 'Pokemon', optional: true
  belongs_to :pokemon

  has_many :form_timelines
  has_many :shiny_form_timelines
  has_many :form_special_days
  has_many :form_raid_timelines
  has_many :form_event_pokemons
  has_many :form_caught_timelines
  has_many :form_breakthrough_timelines
  has_many :form_fast_moves
  has_many :form_charge_moves
end
