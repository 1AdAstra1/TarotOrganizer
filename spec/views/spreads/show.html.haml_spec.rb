require 'spec_helper'

describe "spreads/show" do
  before(:each) do
    @spread = assign(:spread, stub_model(Spread,
      :client_id => 1,
      :name => "Name",
      :structure => "Structure",
      :comment => "Comment",
      :feedback => "Feedback"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/Structure/)
    rendered.should match(/Comment/)
    rendered.should match(/Feedback/)
  end
end
