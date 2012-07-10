require 'spec_helper'

describe "spreads/edit" do
  before(:each) do
    @spread = assign(:spread, stub_model(Spread,
      :client_id => 1,
      :name => "MyString",
      :structure => "MyString",
      :comment => "MyString",
      :feedback => "MyString"
    ))
  end

  it "renders the edit spread form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => spreads_path(@spread), :method => "post" do
      assert_select "input#spread_client_id", :name => "spread[client_id]"
      assert_select "input#spread_name", :name => "spread[name]"
      assert_select "input#spread_structure", :name => "spread[structure]"
      assert_select "input#spread_comment", :name => "spread[comment]"
      assert_select "input#spread_feedback", :name => "spread[feedback]"
    end
  end
end
