module CampaignsHelper
  def state_class(state)
    case state
    when "cancelled"
      "label-danger"
    when "published"
      "label-success"
    when "funded"
      "label-success"
    when "unfunded"
      "label-danger"
    when "archived"
      "label-warning"
    when "draft"
      "label-primary"
    else
      "label-default"
    end
  end
end
