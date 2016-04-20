class Admin::MenteesController < Admin::ApplicationController
  before_action :authenticate_user!

  def index
    @mentees = User.with_role(:mentee)
  end
end