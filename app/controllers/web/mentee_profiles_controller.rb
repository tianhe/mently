class Web::MenteeProfilesController < Web::ApplicationController
  before_action :authenticate_user!

  def edit
    @preference = MenteeProfile.find(params[:id])
  end

  def update
    @preference = MenteeProfile.find(params[:id])
    @preference.update mentee_profile_params
    redirect_to '/preferences'
  end

private
  def mentee_profile_params
    params.require(:mentee_profile).permit(:mentor_criteria, :capacity)
  end  
end
