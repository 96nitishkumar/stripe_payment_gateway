ActiveAdmin.register Room do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :price, :location, :max_days, :user_id, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :location, :max_days, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
# index do
#   selectable_column
#   column :id,order: :desc
#   column :name
#   column :price
#   column :location
#   column :max_days
#   column :user
#   actions
# end



end
