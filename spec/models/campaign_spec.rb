require 'rails_helper'

RSpec.describe Campaign, type: :model do
  def campaign_attributes(new_attributes = {})
    {
      title:       "Valid campaign title",
      goal:        10000000,
      description: "Valid campaign description",
      end_date:    (Time.now + 20.days)
    }.merge(new_attributes)
  end

  describe "Validations" do
    it "requires a title" do
      campaign = Campaign.new campaign_attributes({title: nil})
      expect(campaign).to be_invalid
    end

    it "requires a description" do
      campaign = Campaign.new campaign_attributes({description: nil})
      expect(campaign).to be_invalid
    end

    it "requires a goal" do
      campaign = Campaign.new campaign_attributes({goal: nil})
      expect(campaign).to be_invalid
    end

    it "requires the goal to be more than 10" do
      campaign = Campaign.new campaign_attributes({goal: 1})
      expect(campaign).to be_invalid
    end

    it "requires the title to be unique" do
      title = "some string"
      campaign_1 = Campaign.create(campaign_attributes({title: title}))
      campaign_2 = Campaign.new(campaign_attributes({title: title}))
      expect(campaign_2).to be_invalid
    end

  end
end
