class Costume < ApplicationRecord
  belongs_to :pokemon

  has_many :costume_timelines
  has_many :shiny_costume_timelines
  has_many :costume_special_days
  has_many :costume_raid_timelines
end
