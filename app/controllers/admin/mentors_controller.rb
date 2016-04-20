class Admin::MentorsController < Admin::ApplicationController
  before_action :authenticate_user!
  has_scope :mentor_availability
  
  def index    
    @mentors = apply_scopes(User).with_role(:mentor)
  end
end