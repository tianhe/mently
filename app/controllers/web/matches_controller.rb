class Web::MatchesController < Web::ApplicationController
  def update_multiple
    params['matches'].keys.each do |id|
      match = Match.find(id.to_i)
      match.update_attributes match_params(id)  
    end
    redirect_to request.referer
  end

  private

  def match_params(id)
    params.require(:matches).fetch(id).permit(:mentee_rank, :mentor_rank)
  end
end
