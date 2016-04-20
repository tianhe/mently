class Web::PreferencesController < Web::ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @mentor_preference = current_user.mentor_profile
    @mentee_preference = current_user.mentee_profile
  end

  def edit
    @preference = Preference.find(params[:id])
  end

  def update
    @preference = Preference.find(params[:id])
    @preference.update preference_params
    redirect_to '/preferences'
  end

private
  def preference_params
    params.require(:preference).permit(:description, :capacity)
  end  
end
