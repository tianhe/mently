class Admin::UploadsController < Admin::ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def mentees
    data = params[:file].read

    CSV.parse(data, headers: true, col_sep: "\t", skip_blanks: true) do |row|
      if row[1].present? && row[1] != 'Name'
        email = row[6]
        first_name = row[1].split(' ')[0]
        last_name = row[1].split(' ')[1..-1].join(' ')
        department = row[2]
        location = row[7] || row[9]
        experience = row[3]

        looking_for = row[4]
        bio = row[5]

        user = User.find_or_create_by(email: email) do |user|
          user.password = 'xogroup2016'
          user.password_confirmation = 'xogroup2016'        
        end

        user.profile.update first_name: first_name, last_name: last_name, 
          department: department, location: location, experience: experience          
        user.add_role 'mentee'
        user.mentee_profile.update capacity: 1

        #add mentors - mentee ranks
        rank = {}        
        row.fields(15..17).each do |mentor_name, index|
          next unless mentor_name.present?
          rank[mentor_name] = index

          create_match user, mentor_name, row[18], row[20], rank
        end
        
        #add mentors - mentee matches
        row.fields(11..13).each do |mentor_name|          
          create_match user, mentor_name, row[18], row[20], rank
        end                
      end      
    end

    flash[:notice] = 'Upload successful'
    redirect_to admin_uploads_path
  end

  def mentors
    data = params[:file].read

    CSV.parse(data, headers: true, col_sep: "\t", skip_blanks: true) do |row|
      if row[0].present?
        first_name = row[0].split(' ')[0]
        last_name = row[0].split(' ')[1..-1].join(' ')
        email = row[1]
        title = row[2]
        department = row[3]
        experience = row[4]
        location = row[14]
        linkedin = row[16]
        capacity = row[12]

        user = User.find_or_create_by(email: row[1]) do |user|
          user.password = 'xogroup2016'
          user.password_confirmation = 'xogroup2016'        
        end

        user.profile.update first_name: first_name, last_name: last_name, 
          title: title, department: department, location: location, experience: experience, 
          linkedin_url: linkedin
        user.add_role 'mentor'

        user.mentor_profile.update capacity: capacity
      end      
    end

    flash[:notice] = 'Upload successful'
    redirect_to admin_uploads_path
  end  

  private

  def create_match mentee, mentor_name, matched_mentor_name, match_date, rank
    return unless mentor = User.find_by_full_name(mentor_name)

    Match.find_or_create_by(mentor: mentor, mentee: mentee) do |match|
      match.mentor_rank = rank[mentor_name]

      if mentor_name == matched_mentor_name #matched mentor
        match.status = Match.statuses[:active]

        date = Date.strptime(match_date, '%m/%d/%Y')
        match.start_date = date
      else
        match.status = Match.statuses[:dated]
      end
    end
  end
end