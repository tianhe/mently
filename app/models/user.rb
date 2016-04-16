class User < ActiveRecord::Base
  rolify
  # rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  ## Database authenticatable
  # field :first_name,         type: String, default: ""
  # field :last_name,          type: String, default: ""
  # field :gender,             type: String, default: ""

  #field :authentication_token, type: String
  validates :email, :password, presence: true
  
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
