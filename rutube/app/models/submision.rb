class Submision < ApplicationRecord
  after_create :generate_submissions

end
