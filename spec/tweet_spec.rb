require 'spec_helper'

describe Tweet do
  it "should be a string of less than 140 characters" do
    tweet = Tweet.create(user_id: 1, content: "This is a tweet")

    expect(tweet.content).to eq("This is a tweet")
  end
  it "should belong to a user" do
    User.create(name: 'somejerk', username: 'asdfasdf', password: 'somejerk', location: 'sf')
    tweet = Tweet.create(user_id: 1, content: "This is a tweet")
    user = User.find(tweet.user_id)

    expect(user.name).to eq("somejerk")
  end
end
