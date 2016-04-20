class Admin::MentorsController < Admin::ApplicationController
  before_action :authenticate_user!
  has_scope :is_available_as_mentor
  has_scope :by_department
  
  def index
    @mentors = apply_scopes(User).with_role(:mentor)
  end
end