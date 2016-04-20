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

private
  def create_general_profile
    self.build_profile.save
  end

  def create_mentor_profile
    self.build_mentor_profile(capacity: 1, is_available: false).save
  end

  def create_mentee_profile
    self.build_mentee_profile(capacity: 1, is_available: false).save
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
