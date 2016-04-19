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
  has_many :preferences

  after_create :create_profile
  after_create :create_preferences

private
  def create_profile
    self.build_profile.save
  end

  def create_preferences
    self.preferences.create(role: 'mentor', capacity: 1)
    self.preferences.create(role: 'mentee', capacity: 2)
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
