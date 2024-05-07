ActiveAdmin.register_page "hello" do
ActiveAdmin.setup do |config|
  config.namespace :admin do |admin|
    admin.build_menu :default do |menu|
      menu.add label: 'Users', priority: 1
      menu.add label: 'Bookings', priority: 2
     
    end
  end
end
end
