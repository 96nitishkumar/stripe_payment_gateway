ActiveAdmin.register FaqBlock::Faq,as:'FAQ' do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :category
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :category]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :category
  filter :title
  filter :description
  filter :created_at
  
end
