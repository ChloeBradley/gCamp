namespace :cleanup do

  desc  "Deletes all memberships where their users have already been deleted"
  task delete_membership_without_user: :environment do
    Membership.where(user_id: nil).destroy_all
  end

  desc  "Deletes all memberships where their projects have already been deleted"
  task delete_all_memberships_where_projects_have_been_deleted: :environment do
    Membership.where(project_id: nil).destroy_all
  end

  desc "Deletes all tasks where their projects have been deleted"
  task delete_tasks_without_projects: :environment do
    Task.where(project_id: nil).destroy_all
  end

  desc "Deletes all comments where their tasks have been deleted"
  task delete_all_comments_where_their_tasks_are_deleted: :environment do
    Comment.where(task_id: nil).destroy_all
  end

  desc "Sets the user_id of comments to nil if their users have been deleted"
  task set_user_id_of_comments_to_nil__if_user_was_deleted: :enviroment do
    Comment.where.not(user_id: User.pluck(:id)).update_all(user_id: nil)
  end

  desc "Deletes any task with null project_id"
  task deletes_tasks_with_null_project_id: :environment do
    Task.where(project_id: nil).destroy_all
  end

  desc "Deletes any comments with a null task_id"
  task deletes_comments_without_task_id: :enviroment do
    Comments.where(task_id: nil).destroy_all
  end

  desc "Deletes any memberships with a null project_id or user_id"
  task deletes_memberships_where_project_id_or_user_id_nil: :enviroment do
    Membership.where(user_id: nil, project_id: nil).destroy_all
  end
end


# Deletes all memberships where their users have already been deleted
# Deletes all memberships where their projects have already been deleted
# Deletes all tasks where their projects have been deleted
# Deletes all comments where their tasks have been deleted
# Sets the user_id of comments to nil if their users have been deleted
# Removes any tasks with null project_id
# Removes any comments with a null task_id
# Removes any memberships with a null project_id or user_id
