class Web::PreferencesController < Web::ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @mentor_profile = current_user.mentor_profile
    @mentee_profile = current_user.mentee_profile
  end

end
