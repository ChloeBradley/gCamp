class Membership < ActiveRecord::Base

  ROLE_MEMBER = 'Member'
  ROLE_OWNER = 'Owner'
  ROLE = [ROLE_MEMBER, ROLE_OWNER]


  belongs_to :project
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :project_id, message: "has already been added to this project"
  validates :user_id, presence: true
  validates :role, presence: true

end
