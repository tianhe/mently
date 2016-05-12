class Web::MenteesController < Web::ApplicationController
  def index
    @mentee_candidates = current_user.mentees.dating.order_by_mentee_rank
    @active_mentees = current_user.mentees.active
  end

  def rank
    @mentee_candidate_matches =  current_user.mentee_matches.dating    
  end
end
