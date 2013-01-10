require 'spec_helper'

describe "interpretations/index" do
  before(:each) do
    assign(:interpretations, [
      stub_model(Interpretation,
        :text => "",
        :card_code => "Card Code"
      ),
      stub_model(Interpretation,
        :text => "",
        :card_code => "Card Code"
      )
    ])
  end

  it "renders a list of interpretations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Card Code".to_s, :count => 2
  end
end
