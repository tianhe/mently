class Match < ActiveRecord::Base
  belongs_to :mentor, class_name: "User"
  belongs_to :mentee, class_name: "User"

  after_save :update_availability
  
  def update_availability    
    self.mentor.update_availability 
    self.mentee.update_availability
  end
end