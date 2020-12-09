class FormSpecialDay < ApplicationRecord
  belongs_to :special_day_type
  belongs_to :form
end
