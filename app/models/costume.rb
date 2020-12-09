class Costume < ApplicationRecord
  belongs_to :pokemon

  has_many :costume_timelines
  has_many :shiny_costume_timelines
end
