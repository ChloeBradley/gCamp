class User < ActiveRecord::Base

  def hidden
    unless tracker_token == nil
      if tracker_token != ""
        stars = tracker_token.length - 4
        "#{tracker_token[0..3]}#{'*'*stars}"
      end
    end
  end

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

  def admin?
    self.admin
  end

  def co_member?(user)
    # user.projects.map {|project| project.users}.flatten.include?(self)
    # user.projects.map {&:users}.flatten.include?(self)

    results = []
    user.projects.each do |project|
      results << project.users
    end
    results.flatten.include?(self)
  end



  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true

  has_many :memberships, dependent: :destroy
  has_many :tasks, through: :projects
  has_many :comments, through: :tasks
  has_many :projects, through: :memberships

  has_secure_password

end
