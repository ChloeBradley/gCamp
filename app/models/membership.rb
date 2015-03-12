class Membership < ActiveRecord::Base

  ROLE = ["Member", "User"]

  belongs_to :project
  belongs_to :user
end
