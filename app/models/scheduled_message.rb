class ScheduledMessage < ActiveRecord::Base
  acts_as_paranoid
  acts_as_taggable

  include MessageConcerns

  has_many :sent_scheduled_messages, dependent: :destroy

  validates :days_after_start, presence: true, unless: 'quarterly?'
  validates :time_of_day, presence: true

  enum type: [:onboarding, :quarterly]

  # disable STI
  self.inheritance_column = nil

  def self.active
    where('end_date IS NULL OR end_date > ?', Date.today)
  end

  def self.date_time_ordering
    order(:days_after_start, :time_of_day)
  end

end
