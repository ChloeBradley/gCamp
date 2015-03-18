class Task < ActiveRecord::Base

  validates :due_date, presence: true
  validates :description, presence: true
  belongs_to :project


  has_many :comments

end
