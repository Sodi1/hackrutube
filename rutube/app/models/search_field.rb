class SearchField < ApplicationRecord
  enum kind: [:string, :datetime, :numeric]
  scope :active, -> { where(active: true) }
end
