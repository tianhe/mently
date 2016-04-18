class Profile < ActiveRecord::Base
  belongs_to :user

  enum gender: [:male, :female]

end
