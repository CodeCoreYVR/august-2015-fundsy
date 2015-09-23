require 'rails_helper'

RSpec.describe "discussions/edit", type: :view do
  before(:each) do
    @discussion = assign(:discussion, Discussion.create!(
      :body => "MyText"
    ))
  end

  it "renders the edit discussion form" do
    render

    assert_select "form[action=?][method=?]", discussion_path(@discussion), "post" do

      assert_select "textarea#discussion_body[name=?]", "discussion[body]"
    end
  end
end
