require 'spec_helper'

describe "interpretations/show" do
  before(:each) do
    @interpretation = assign(:interpretation, stub_model(Interpretation,
      :text => "",
      :card_code => "Card Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Card Code/)
  end
end
