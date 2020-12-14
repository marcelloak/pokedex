class EventTimeline < ApplicationRecord
  has_many :event_pokemons
  has_many :costume_event_pokemons
  has_many :form_event_pokemons
end
