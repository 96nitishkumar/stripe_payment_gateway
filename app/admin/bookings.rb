ActiveAdmin.register Booking do
menu parent: "Booking"
# menu label: 'book'
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :room_id, :status, :from_date, :to_date, :booking_days, :total_price
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :room_id, :status, :from_date, :to_date, :booking_days, :total_price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

   form do |f|
    f.inputs do
      f.input :user
      f.input :room
      f.input :status
      f.input :from_date
      f.input :to_date,as: :datepicker
      f.input :booking_days
      f.input :total_price
    end
    f.actions
  end
  
end
