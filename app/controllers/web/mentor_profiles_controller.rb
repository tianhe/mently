class Web::MentorProfilesController < Web::ApplicationController
  before_action :authenticate_user!

  def edit
    @preference = MentorProfile.find(params[:id])
  end

  def update
    @preference = MentorProfile.find(params[:id])
    @preference.update mentor_profile_params
    redirect_to '/preferences'
  end

private
  def mentor_profile_params
    params.require(:mentor_profile).permit(:description, :capacity)
  end  
end
