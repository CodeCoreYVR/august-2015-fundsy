class CampaignDecorator < Draper::Decorator
  # this means if you create a decorator object from an activerecord object
  # and call a method on the decorator, it will just call that method on the
  # activerecord object.
  delegate_all

  TRUNCATION_CHARACTER_LIMIT = 35

  def upcased_title
    object.title.upcase
  end

  def end_date
    object.end_date.strftime("%Y-%b-%d %H:%M")
  end

  def goal
    h.number_to_currency(object.goal)
  end

  def state_label
    label_classes = "label #{h.state_class(object.aasm_state)}"
    h.content_tag :span, class: label_classes do
      object.aasm_state
    end
    # <span class="label <%= state_class(@campaign.aasm_state) %>">
    #   <%= @campaign.aasm_state %>
    # </span>
  end

  def publish_button
    if object.may_publish?
      h.link_to("Publish", h.campaign_publishings_path(object),
                {method: :post, class: "btn btn-primary"})
    end
  end

  def cancel_button
    if object.may_cancel?
      h.link_to "Cancel", h.campaign_cancellings_path(object), method: :post,
                              class: "btn btn-danger",
                              data: {confirm: "Are you sure?"}
    end
  end

  def edit_button
    h.link_to "Edit", h.edit_campaign_path(object), class: "btn btn-info"
  end

  def delete_button
    h.link_to "Delete", object, class: "btn btn-danger",
              data: {confirm: "Are you sure?"}, method: :delete
  end

  def truncated_description
    object.description.truncate(TRUNCATION_CHARACTER_LIMIT)
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
