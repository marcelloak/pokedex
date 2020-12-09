class SpecialDay < ApplicationRecord
  belongs_to :special_day_type
  belongs_to :pokemon
end
