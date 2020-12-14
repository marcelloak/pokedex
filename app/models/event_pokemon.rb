class EventPokemon < ApplicationRecord
  belongs_to :pokemon
  belongs_to :event_timeline
end
