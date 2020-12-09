class SpecialLeagueTimeline < ApplicationRecord
  belongs_to :gbl_timeline
  
  has_many :special_league_type_limits
end
