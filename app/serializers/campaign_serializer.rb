class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :url

  has_many :rewards

  def url
    campaign_path(object)
  end

  def description
    decorated_object.truncated_description
  end

  private

  def decorated_object
    object.decorate
  end
end
