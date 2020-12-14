class CostumeEventPokemon < ApplicationRecord
  belongs_to :costume
  belongs_to :event_timeline
end
