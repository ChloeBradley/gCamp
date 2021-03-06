require 'rails_helper'

describe User do

  before do
    @user = User.new(first_name: "first", last_name: "last", email: "example@example.com")
  end

  it 'should be invaild without first name' do
    @user.update_attributes(first_name: "")
    @user.valid?
    expect(@user.errors[:first_name]).to include("can't be blank")
end

it 'should be invaild without last name' do
  @user.update_attributes(last_name: "")
  @user.valid?
  expect(@user.errors[:last_name]).to include("can't be blank")
end
end
