json.array! @campaigns do |campaign|
  json.id          campaign.id
  json.title       campaign.title
  json.user_name   campaign.user.full_name
  json.description campaign.truncated_description
  json.url         api_v1_campaign_url(campaign)
  json.created_at  campaign.created_at.strftime("%Y-%B-%d")
end
