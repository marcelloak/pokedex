class CostumeSpecialDay < ApplicationRecord
  belongs_to :special_day_type
  belongs_to :costume
end
