def create_user(overrides = {})
  User.create!({
    first_name: 'Jenny',
    last_name: 'Fronk',
    email: "User#{rand(100..999)}email@example.com",
    password: "Password",
    admin: false
 }.merge(overrides))
end

def create_project(options = {})
  Project.create!({
    name: 'Test Project'
  }.merge(options))
end

def create_membership(options = {})
  Membership.create!({
    project_id: create_project.id,
    user_id: create_user.id,
    role: 'Member'
  }.merge(options))
end

def create_task(options = {})
  Task.create!({
    description: "string",
    complete: true,
    project_id: 2,
  }.merge(options))
end

# user = create_user
# project = create_project
# membership = create_membership(project_id: project.id, user_id: user.id, role: 'Owner')
