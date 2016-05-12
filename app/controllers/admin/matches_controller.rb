class Admin::MatchesController < Admin::ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.find_by(id: params[:user_id])
    @candidate_options = User.available_mentors_and_ids
    @user.associated_users.each{ |u| @candidate_options.delete(u) }
  end
  
  def index
    @user = User.find_by(id: params[:user_id])

    @mentor_candidates = @user.mentors.dating
    @mentee_candidates = @user.mentees.dating
    @past_mentor_candidates = @user.mentors.dated
    @past_mentee_candidates = @user.mentees.dated

    @active_mentors = @user.mentors.active
    @active_mentees = @user.mentees.active
    @past_mentors = @user.mentors.inactive
    @past_mentees = @user.mentees.inactive
  end

  def create
    match = Match.create(mentor_id: params[:mentor_id], mentee_id: params[:user_id], status: 'dating')
    redirect_to "/admin/users/#{params[:user_id]}/matches"
  end

  def update
  end

  def edit
  end

end
