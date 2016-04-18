class Web::Users::RegistrationsController < Devise::RegistrationsController
  # def new
  #   super
  # end

  def create
    super
    if params["user"]["_roles"]
      params["user"]["_roles"].each do |r|
        resource.add_role r
      end
    end
  end
end
