class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates :text, presence: true


end
