require 'rails_helper'

feature "user can see gCamp on root page" do
  it "gCamp is present" do
    visit root_path
    expect(page).to have_content "gCamp"
  end
end
