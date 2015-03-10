def login(password = 'password', user = create_user)
  visit signin_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: password
  within ".well" do
    click_on 'Sign In'
  end
end
