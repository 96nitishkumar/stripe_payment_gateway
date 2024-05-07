ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :email, :password, :phone_number
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password_digest, :phone_number]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

    index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone_number
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :phone_number
    end
    f.actions
  end


  show do
    attributes_table do
      row :name
      # row :image do |ad|
      #   image_tag ad.image.url
      # end
       # transactions = TransactionBlock::Transaction.where(user_id: params[:id])
      row :rooms
      row :transactions
    end
    active_admin_comments_for(resource)
  end
  
end
