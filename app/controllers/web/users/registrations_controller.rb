class Web::Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    
    resource.profile.update_attributes first_name: params["user"]["first_name"], last_name: params["user"]["last_name"]
    if params["user"]["_roles"]
      params["user"]["_roles"].each do |r|
        resource.add_role r
        if r == 'mentor'
          resource.mentor_profile.update_attributes capacity: 2
        elsif r == 'mentee'
          resource.mentee_profile.update_attributes capacity: 1
        end
      end
    end
  end
end
