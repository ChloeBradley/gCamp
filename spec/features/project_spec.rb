require 'rails_helper'

feature 'project' do


  scenario 'user can see index page' do
    user = User.create!(first_name:"John", last_name: "Doe", email: "john@example.com", password: "password")
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within ".form-horizontal" do
      click_on 'Sign In'
    end
    expect(page).to have_content "gCamp"
    click_on "Projects"
    expect(page).to have_content "Projects"
  end


  scenario 'create a new project' do
    user = User.create!(first_name:"John", last_name: "Doe", email: "john@example.com", password: "password")
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within ".form-horizontal" do
      click_on 'Sign In'
    end
    visit projects_path
    click_on "New Project"
    expect(page).to have_content "Create Project"
    fill_in 'Name', with: "Read my book"
    click_button "Create Project"
  end

  xscenario 'user can create a project' do
    visit new_project_path
    fill_in :project_name, with: "Brush dog"
    click_button "Create Project"

    expect(page).to have_content "Project was successfully created"
    expect(page).to have_content "Brush dog"
  end

  xscenario 'user can edit project' do
    project = Project.new(name: "Do gCamp stuff")
    project.save!
    visit projects_path

    click_link "Do gCamp stuff"
    click_link "Edit"
    fill_in :project_name, with: "Come on! Do it already!"
    click_button "Update Project"
    expect(page).to have_content "Project was successfully updated!"
    expect(page).to have_content "Come on! Do it already!"
    end

    xscenario 'user can delete project' do
      project = Project.new(name: "Do gCamp stuff")
      project.save!
      visit project_path(project)
      click_link "Destroy"

      expect(page).to have_content "Project was successfully deleted"
    end

    xscenario 'user can see validation method displayed' do
      visit projects_path
      click_link "New Project"
      fill_in :project_name, with: ""
      click_button "Create Project"
      expect(page).to have_content '1 error prohibited this post from being saved:'

      end
    end
