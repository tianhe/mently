class Web::MenteesController < Web::ApplicationController
  def index
    @mentee_candidates = current_user.mentees.dating
    @active_mentees = current_user.mentees.active
  end
end
