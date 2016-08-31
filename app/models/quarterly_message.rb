class QuarterlyMessage < ApplicationRecord
  include MessageConcerns
  acts_as_taggable
end
