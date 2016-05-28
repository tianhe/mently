class User < ActiveRecord::Base
  rolify
  # rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # devise :omniauthable, :omniauth_providers => [:facebook]

  #field :authentication_token, type: String
  validates :email, :password, presence: true
  has_one :profile
  has_one :mentor_profile
  has_one :mentee_profile

  after_create :create_general_profile
  after_create :create_mentor_profile
  after_create :create_mentee_profile

  has_many :mentee_matches, class_name: 'Match', foreign_key: 'mentor_id'
  has_many :mentees, through: :mentee_matches

  has_many :mentor_matches, class_name: 'Match', foreign_key: 'mentee_id'
  has_many :mentors, through: :mentor_matches  

  scope :is_available_as_mentor, -> availability { includes(:mentor_profile).where("mentor_profiles.is_available = ?", availability).references(:mentor_profile) }
  scope :is_available_as_mentee, -> availability { includes(:mentee_profile).where("mentee_profiles.is_available = ?", availability).references(:mentee_profile) }
  scope :by_department, -> department { includes(:profile).where("profiles.department = ?", department).references(:profile) }

  scope :active, -> { where(matches: {status: Match.statuses[:active]}) }
  scope :inactive, -> { where(matches: {status: Match.statuses[:inactive]}) }
  scope :dating, -> { where(matches: {status: Match.statuses[:dating]}) }
  scope :dated, -> { where(matches: {status: Match.statuses[:dated]}) }
  scope :waiting_to_confirm, -> { where(matches: {status: Match.statuses[:waiting_to_confirm]}) }
  scope :order_by_mentor_rank, -> { order("matches.mentor_rank") }
  scope :order_by_mentee_rank, -> { order("matches.mentee_rank") }
  
  def update_availability
    update_mentor_availability
    update_mentee_availability
  end

  def is_available_as_mentee?
    self.mentee_profile.is_available
  end

  def is_available_as_mentor?
    self.mentor_profile.is_available
  end

  def self.available_mentors_and_ids
    Hash[User.is_available_as_mentor(true).map{ |u| [u.full_name, u.id] }]
  end

  def associated_users
    mentees.map(&:full_name) + mentors.map(&:full_name) + [full_name]
  end

  def full_name
    "#{profile.first_name} #{profile.last_name}".titleize
  end

  def self.find_by_full_name full_name
    return nil unless full_name.present?
    
    first_name = full_name.split(' ')[0]
    last_name = full_name.split(' ')[1..-1].join(' ')
    
    Profile.where(first_name: first_name, last_name: last_name).first.try(:user)
  end

  def match_with_mentor mentor
    self.mentor_matches.dating.find_by(mentor: mentor).update(status: :waiting_to_confirm)
    self.mentor_matches.dating.where.not(mentor: mentor).update_all(status: 1)    
  end

private
  def update_mentor_availability
    self.mentor_profile.update_availability
  end

  def update_mentee_availability
    self.mentee_profile.update_availability
  end

  def create_general_profile
    self.build_profile.save
  end

  def create_mentor_profile
    self.build_mentor_profile(capacity: 0).save
  end

  def create_mentee_profile
    self.build_mentee_profile(capacity: 0).save
  end


#   has_many  :authentications
#   accepts_nested_attributes_for :authentications

#   before_save :ensure_authentication_token
#   before_validation :ensure_password

#   def self.new_with_session(params, session)
#     super.tap do |user|
#       if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
#         user.email = data["email"] if user.email.blank?
#       end
#     end
#   end

# private
#   def ensure_password
#     self.password ||= Devise.friendly_token.first(8)
#   end

#   def ensure_authentication_token
#     self.authentication_token ||= Devise.friendly_token
#   end
end
