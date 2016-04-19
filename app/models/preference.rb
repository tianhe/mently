class Preference < ActiveRecord::Base
  belongs_to :user
  scope :mentor, -> { where(role: 'mentor') }
  scope :mentee, -> { where(role: 'mentee') }
end
