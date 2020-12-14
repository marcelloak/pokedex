class FormEventPokemon < ApplicationRecord
  belongs_to :form
  belongs_to :event_timeline
end
