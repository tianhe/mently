class Admin::HomeController < Admin::ApplicationController
  before_action :authenticate_user!

  def index
  end
end