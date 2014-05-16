require 'spec_helper'

  describe "index" do
    context "when the create button is clicked" do
      it "should display the create a user page" do
        get '/create'
        expect(last_response.body).to include("Enter your")
        # last_response.ok?
    end
  end
end