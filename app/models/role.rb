class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :resource, :polymorphic => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  def self.defined_roles
    self.all.map { |role| role.name  }
  end
end
