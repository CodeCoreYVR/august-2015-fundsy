require 'rails_helper'

RSpec.describe "discussions/index", type: :view do
  before(:each) do
    assign(:discussions, [
      Discussion.create!(
        :body => "MyText"
      ),
      Discussion.create!(
        :body => "MyText"
      )
    ])
  end

  it "renders a list of discussions" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
