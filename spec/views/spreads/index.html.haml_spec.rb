require 'spec_helper'

describe "spreads/index" do
  before(:each) do
    assign(:spreads, [
      stub_model(Spread,
        :client_id => 1,
        :name => "Name",
        :structure => "Structure",
        :comment => "Comment",
        :feedback => "Feedback"
      ),
      stub_model(Spread,
        :client_id => 1,
        :name => "Name",
        :structure => "Structure",
        :comment => "Comment",
        :feedback => "Feedback"
      )
    ])
  end

  it "renders a list of spreads" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Structure".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => "Feedback".to_s, :count => 2
  end
end
