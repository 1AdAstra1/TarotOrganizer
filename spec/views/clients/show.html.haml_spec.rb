require 'spec_helper'

describe "clients/show" do
  before(:each) do
    @client = assign(:client, stub_model(Client,
      :name => "Name",
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Comment/)
  end
end
