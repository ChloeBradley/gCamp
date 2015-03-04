require 'rails_helper'

feature "Task" do
  scenario "user can see index page" do
    task=Task.new(description:"string", due_date:"2015-03-12")
    task.save!

    visit tasks_path
    expect(page).to have_content "string"
    expect(page).to have_content "03/12/2015"
  end

  scenario "user can create new task" do
    visit tasks_path
    click_link "New Task"
    expect(page).to have_content "New Task"

    fill_in :task_description, with: "Anything!"
    fill_in :task_due_date, with: '2015-04-12'
    click_button "Create Task"

    expect(page).to have_content "Task was successfully created!"
    expect(page).to have_content "Anything!"
    expect(page).to have_content "04/12/2015"
  end

  scenario "user can edit task" do
    task=Task.new(description:"string", due_date:"2015-03-12")
    task.save!
    visit tasks_path
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
    task=Task.new(description:"string", due_date:"2015-03-12")
    task.save!
    visit tasks_path
    click_link "Destroy"
  end

  scenario 'can see validations without a description' do
    visit new_task_path
    fill_in :task_due_date, with: "2015-03-12"
    click_button "Create Task"
    expect(page).to have_content '1 error prohibited this post from being saved:
                                  Description can\'t be blank'
  end
end
