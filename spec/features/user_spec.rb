require 'rails_helper'

  feature 'Users' do

    scenario 'can see index page' do
      user = User.new(first_name: "Champ", last_name: "Ian", email: "Champ@ian.com")
      user.save!

      visit users_path
      expect(page).to have_content "Users"
      expect(page).to have_content "Champ"
      expect(page).to have_content "Ian"
      expect(page).to have_content "Champ@ian.com"
    end

    scenario 'create user' do
      visit users_path
      click_link "New User"

      fill_in :user_first_name, with: "Champ"
      fill_in :user_last_name, with: "Ian"
      fill_in :user_email, with: "Champ@ian.com"

      click_button "Create User"

      expect(page).to have_content "User was successfully created!"
      expect(page).to have_content "Champ"
      expect(page).to have_content "Ian"
      expect(page).to have_content "Champ@ian.com"
    end

    scenario 'edit user' do
      user = User.new(first_name: "Champ", last_name: "Ian", email: "Champ@ian.com")
      user.save!
      visit users_path
      click_link "Edit"

      expect(page).to have_content "Edit User"
      fill_in :user_first_name, with: "Champo-bo-bamp-o"
      fill_in :user_last_name, with: "Ian"
      fill_in :user_email, with: "Champ@ian.com"
      click_button "Update User"

      expect(page).to have_content "User was successfully updated!"
      expect(page).to have_content "Champo-bo-bamp-o"
    end

    scenario 'delete user' do
      user = User.new(first_name: "Champ", last_name: "Ian", email: "Champ@ian.com")
      user.save!
      visit users_path

      click_link "Champ Ian"
      click_link "Edit User"
      click_link "Delete User"
    end
end
