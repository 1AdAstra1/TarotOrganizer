require 'spec_helper'

describe "interpretations/edit" do
  before(:each) do
    @interpretation = assign(:interpretation, stub_model(Interpretation,
      :text => "",
      :card_code => "MyString"
    ))
  end

  it "renders the edit interpretation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => interpretations_path(@interpretation), :method => "post" do
      assert_select "input#interpretation_text", :name => "interpretation[text]"
      assert_select "input#interpretation_card_code", :name => "interpretation[card_code]"
    end
  end
end
