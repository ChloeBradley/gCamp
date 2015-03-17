class User < ActiveRecord::Base


  def full_name
      "#{first_name} #{last_name}"
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true

  has_many :memberships
  has_many :tasks, through: :projects

  has_secure_password

end
