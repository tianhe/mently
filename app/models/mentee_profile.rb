class MenteeProfile < ActiveRecord::Base
  belongs_to :user

  before_save :update_availability, if: :capacity_changed?

  def update_availability    
    if self.capacity > 0
      self.is_available = self.capacity > user.mentors.active.count
    else
      self.is_available = false 
    end
    true
  end
end
