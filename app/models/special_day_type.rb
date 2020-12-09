class SpecialDayType < ApplicationRecord
  has_many :special_days
  has_many :form_special_days
  has_many :costume_special_days
end
