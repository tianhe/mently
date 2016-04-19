class Admin::MentorsController < Admin::ApplicationController
  before_action :authenticate_user!

  def index
    @mentors = User.with_role(:mentor)
  end
end