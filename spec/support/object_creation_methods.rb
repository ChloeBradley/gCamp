def create_user(overrides = {})
  User.create!({
   :first_name => 'Jenny',
   :last_name => 'Fronk',
   :email => "User#{rand(100..999)}email@example.com",
   :password => "Password"
 }.merge(overrides))
end
