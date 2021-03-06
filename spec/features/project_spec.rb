require 'rails_helper'

feature 'project' do


  scenario 'user can see index page' do
    user = User.create!(first_name:"John", last_name: "Doe", email: "john@example.com", password: "password", admin: true)
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within ".form-horizontal" do
      click_on 'Sign In'
    end
    expect(page).to have_content "Projects"
  end


  scenario 'create a project and see it on index page' do
    user = User.create!(first_name:"John", last_name: "Doe", email: "john@example.com", password: "password", admin: true)
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within ".form-horizontal" do
      click_on 'Sign In'
    end
    visit projects_path
    within '.navbar' do
      click_on "New Project"
    end
    expect(page).to have_content "New Project"
    fill_in 'Name', with: "Read my book"
    click_button "Create Project"

    expect(page).to have_content "Project was successfully created"
    expect(page).to have_content "Read my book"
    end

  scenario 'user can edit project' do
    user = User.create!(first_name:"John", last_name: "Doe", email: "john@example.com", password: "password", admin: true)
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within ".form-horizontal" do
      click_on 'Sign In'
    end
    visit projects_path
    within '.navbar' do
      click_on "New Project"
    end
    fill_in "Name", with: "A Great book!"
    click_button "Create Project"
    visit projects_path
    within '.navbar' do
      click_link "A Great book!"
    end
    click_link "Edit"
    expect(page).to have_content "Edit Project"
    fill_in :project_name, with: "Read my GREAT book!"
    within ".form-horizontal" do
    click_button "Update Project"
    end
    expect(page).to have_content "Project was successfully updated!"
    end
    
    scenario 'user can see validation method displayed' do
      user = User.create!(first_name:"John", last_name: "Doe", email: "john@example.com", password: "password", admin: true)
      visit signin_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      within ".form-horizontal" do
        click_on 'Sign In'
      end
      visit projects_path
      within '.navbar' do
        click_link "New Project"
      end
      fill_in :project_name, with: ""
      click_button "Create Project"
      expect(page).to have_content '1 error prohibited this post from being saved:'

      end
    end
