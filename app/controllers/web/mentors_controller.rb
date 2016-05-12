class Web::MentorsController < Web::ApplicationController
  def index
    @mentor_candidates = current_user.mentors.dating.order_by_mentor_rank
    @mentor_dating_match = current_user.mentor_matches.dating.order(:mentor_rank)
    @active_mentors = current_user.mentors.active
  end

  def rank
    @mentor_candidate_matches =  current_user.mentor_matches.dating
  end
end
