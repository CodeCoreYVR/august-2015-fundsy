require 'rails_helper'

RSpec.describe "discussions/new", type: :view do
  before(:each) do
    assign(:discussion, Discussion.new(
      :body => "MyText"
    ))
  end

  it "renders new discussion form" do
    render

    assert_select "form[action=?][method=?]", discussions_path, "post" do

      assert_select "textarea#discussion_body[name=?]", "discussion[body]"
    end
  end
end
