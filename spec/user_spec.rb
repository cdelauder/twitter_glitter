require 'spec_helper'

describe User do
  it "should be able to create an account" do
    user = User.create(name: 'somejerk', username: 'asdfasdf', password: 'somejerk', location: 'sf')
    name = user.username

    expect(name).to eq('asdfasdf')
  end

  it "should be unable to create an account unless they have selected a unique username" do
    User.create(name: 'someotherjerk', username: 'asdfasdf', password: 'someotherjerk', location: 'sf')
    user = User.create(name: 'somejerk', username: 'asdfasdf', password: 'somejerk', location: 'sf')
    error = user.errors.full_messages[0]

    expect(error).to eq('Username has already been taken')
  end
end

