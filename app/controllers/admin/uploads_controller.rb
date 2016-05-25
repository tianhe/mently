class Admin::UploadsController < Admin::ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def mentors
    data = params[:file].read

    CSV.parse(data, headers: true, col_sep: "\t", skip_blanks: true) do |row|
      if row[0].present?
        first_name = row[0].split(' ')[0]
        last_name = row[0].split(' ')[1..-1].first
        email = row[1]
        title = row[2]
        department = row[3]
        experience = row[4]
        location = row[14]
        linkedin = row[16]
        user = User.find_or_create_by(email: row[1]) do |user|
          user.password = 'xogroup2016'
          user.password_confirmation = 'xogroup2016'        
        end

        user.profile.update first_name: first_name, last_name: last_name, 
          title: title, department: department, location: location, experience: experience, 
          linkedin_url: linkedin
        user.add_role 'mentor'
      end      
    end

    flash[:notice] = 'Upload successful'
    redirect_to admin_uploads_path
  end  
end