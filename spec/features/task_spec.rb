require 'rails_helper'

feature "Task" do
  scenario "user can see index page" do
    task=Task.new(description:"Be a happy camper", due_date:"2015-03-12")
    task.save!
    user = User.create!(first_name:"John", last_name: "Doe", email: "john@example.com", password: "password", admin: true)
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within ".form-horizontal" do
      click_on 'Sign In'
    end
    visit projects_path
    expect(page).to have_content "Projects"
  end

  scenario "user can create new task" do
      user = User.create!(first_name:"John", last_name: "Doe", email: "john@example.com", password: "password", admin: true)
      visit signin_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      within ".form-horizontal" do
        click_on 'Sign In'
      end
    end

  scenario "user can edit task" do
    user = User.create!(first_name:"John", last_name: "Doe", email: "john@example.com", password: "password", admin: true)
    project = Project.create!(name:"project")
    task=Task.create!(description:"string", due_date:"2015-03-12", project_id: project.id)
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within ".form-horizontal" do
      click_on 'Sign In'
    end
    expect(page).to have_content "Projects"
    click_link "1"
    click_link "Edit"

    expect(page).to have_content "Edit task"
    fill_in :task_description, with: "More Things!"
    fill_in :task_due_date, with: "2014-03-03"
    click_button "Update Task"

    expect(page).to have_content "Task was successfully updated!"
    expect(page).to have_content "More Things!"
    expect(page).to have_content "03/03/2014"
  end

  scenario "users can delete a task" do
    user = User.create!(first_name:"John", last_name: "Doe", email: "john@example.com", password: "password", admin: true)
    project = Project.create!(name:"project")
    task=Task.create!(description:"string", due_date:"2015-03-12", project_id: project.id)
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within ".form-horizontal" do
      click_on 'Sign In'
  end
    click_link "1"
    page.find(".glyphicon-remove").click
    expect(page).to have_content "Task was successfully deleted."

  end

  scenario 'can see validations without a description' do
    user = User.create!(first_name:"John", last_name: "Doe", email: "john@example.com", password: "password", admin: true)
    project = Project.create!(name:"project")
    task=Task.create!(description:"string", due_date:"2015-03-12", project_id: project.id)
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within ".form-horizontal" do
      click_on 'Sign In'
    end
    within '.navbar' do
      click_link "New Project"
    end
    fill_in :project_name, with: ""
    click_button "Create Project"
    expect(page).to have_content '1 error prohibited this post from being saved:
                                  Name can\'t be blank'
  end
end
