class Role < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  def self.available_roles
   %w(manager editor viewer)
  end
  
end
