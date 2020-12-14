class Pokemon < ApplicationRecord
  belongs_to :generation
  belongs_to :family
  belongs_to :primary_type, :class_name => 'Type'
  belongs_to :secondary_type, :class_name => 'Type'
  belongs_to :evolves_from, :class_name => 'Pokemon'

  has_many :pokemons
  has_many :forms
  has_many :costumes
  has_many :pokemon_charge_moves
  has_many :pokemon_fast_moves
  has_many :pokemon_timelines
  has_many :shiny_timelines
  has_many :shadow_timelines
  has_many :shiny_shadow_timelines
  has_many :special_days
  has_many :raid_timelines
  has_many :breakthrough_timelines
  has_many :pokemon_caught_timelines
  has_many :event_pokemons
end
