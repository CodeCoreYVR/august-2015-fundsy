ActiveAdmin.register Campaign do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
permit_params do
  [:title, :description, :goal, :end_date,
      rewards_attributes: [:amount, :description, :id, :_destroy]]
end


end
