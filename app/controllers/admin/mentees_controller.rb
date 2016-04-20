class Admin::MenteesController < Admin::ApplicationController
  before_action :authenticate_user!
  has_scope :is_available_as_mentee

  def index
    @mentees = apply_scopes(User).with_role(:mentee)
  end
end