require 'rails_helper'

RSpec.describe "discussions/show", type: :view do
  before(:each) do
    @discussion = assign(:discussion, Discussion.create!(
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
