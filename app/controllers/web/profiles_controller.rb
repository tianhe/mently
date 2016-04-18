class Web::ProfilesController < Web::ApplicationController
  def show
    @profile = current_user.profile
    @user = current_user
  end

  def edit    
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    @profile.update profile_params
    redirect_to edit_profile_path
  end

private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :gender, :linkedin_url, :department, :experience, :location)
  end  
end