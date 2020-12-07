class Form < ApplicationRecord
  belongs_to :primary_type, :class_name => 'Type'
  belongs_to :secondary_type, :class_name => 'Type'
  belongs_to :evolves_from, :class_name => 'Pokemon'
end
