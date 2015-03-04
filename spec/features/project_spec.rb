require 'rails_helper'

feature 'project' do

  scenario 'user can see index page' do
    project = Project.new(name: "Do gCamp stuff")
    project.save!

    visit projects_path
    expect(page).to have_content "Projects"
    expect(page).to have_content "Do gCamp stuff"
    expect(page).to have_content "New Project"
  end

  scenario 'user can create a project' do
    visit new_project_path
    fill_in :project_name, with: "Brush dog"
    click_button "Create Project"

    expect(page).to have_content "Project was successfully created"
    expect(page).to have_content "Brush dog"
  end

  scenario 'user can edit project' do
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

    scenario 'user can delete project' do
      project = Project.new(name: "Do gCamp stuff")
      project.save!
      visit project_path(project)
      click_link "Destroy"

      expect(page).to have_content "Project was successfully deleted"
    end
end
