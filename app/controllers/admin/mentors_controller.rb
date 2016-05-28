class Admin::MentorsController < Admin::ApplicationController
  before_action :authenticate_user!
  has_scope :is_available_as_mentor
  has_scope :by_department
  
  def index
    @mentors = apply_scopes(User).with_role(:mentor)
    @departments = [''] + Profile.pluck(:department).uniq.compact
  end

  def upload
    data = params[:file].read

    CSV.parse(data, headers: true, col_sep: "\t") do |row|
      next unless row[0]

      first_name = row[0].split(' ')[0]
      last_name = row[0].split(' ')[1..-1]
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

      user.profile.update first_name: first_name, last_name: last_name, email: email, 
        title: title, department: department, location: location, experience: experience, 
        linkedin_url: linkedin
    end

  end  
end