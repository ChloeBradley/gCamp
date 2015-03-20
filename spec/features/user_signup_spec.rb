require 'rails_helper'

feature 'User signup flow' do
  scenario 'allows a user to sign up' do
    visit root_path
    expect(page).to have_content 'gCamp'

    click_link 'Sign Up'
    expect(current_path).to eq '/sign-up'
    expect(page).to have_content 'Sign up for gCamp!'

    fill_in :user_first_name, with: 'Johnny'
    fill_in :user_last_name, with: 'Cash'
    fill_in :user_email, with: 'IhaveCash@yahoo.com'
    fill_in :user_password, with: 'bigcash'
    fill_in :user_password_confirmation, with: 'bigcash'
    click_button 'Sign Up'

    expect(current_path).to eq '/projects/new'
    expect(page).to have_content 'gCamp'
    expect(page).to have_content 'You have successfully signed up'
  end
end
