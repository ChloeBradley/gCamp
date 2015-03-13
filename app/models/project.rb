class Project < ActiveRecord::Base

  validates :user, presence: true
  validates :role, presence: true

  validates :name, presence: true
  has_many :tasks
  has_many :memberships


end
