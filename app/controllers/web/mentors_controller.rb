class Web::MentorsController < ApplicationController
  def index
    @mentor_candidates = current_user.mentors.dating
    @active_mentors = current_user.mentors.active
  end
end
