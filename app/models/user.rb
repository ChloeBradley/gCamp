class User < ActiveRecord::Base


  def full_name
      "#{first_name} #{last_name}"
  end

  def is_project_member(project)
  if project.memberships.find_by(user_id: self.id)
    return true
  else
    false
  end
end

def is_project_owner(project)
  if project.memberships.find_by(user_id: self.id, role: Membership::ROLE_OWNER)
    return true
  else
    false
  end
end



  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true

  has_many :memberships
  has_many :tasks, through: :projects
  has_many :comments, through: :tasks
  has_many :projects, through: :memberships

  has_secure_password

end
