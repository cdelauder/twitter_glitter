require 'spec_helper'

  describe "index" do
    context "when the create button is clicked" do
      it "should display the create a user page" do
        get 'http://localhost:9393/create'
        assert last_response.ok?
    end
  end
end