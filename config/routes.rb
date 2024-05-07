Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :users
  resources :bookings
  resources :rooms
  resources :devices
  post "signup", to: "users#signup"
  post "login", to:"users#login"
  get 'home/:id',to:'users#home'
  get "user_bookigs", to: "bookings#user_bookigs"
  get "owner_bookings", to: "bookings#owner_bookings"
  get "properties", to: "rooms#properties"
  get "user_feature_bookings", to: "bookings#user_feature_bookings"
  get "user_properties", to: "rooms#user_properties"
  patch "update_owner", to: 'bookings#update_owner'
  get "owner_feature_bookings", to: "bookings#owner_feature_bookings"
  get "check_avaliable_date", to:"rooms#check_avaliable_date"
  get "check_available_rooms", to: "rooms#check_available_rooms"
  patch 'cancel_booking',to:'bookings#cancel_booking'

  namespace :transaction_block do
    resources :transactions
    post 'create_customer',to:'customers#create_customer'
    post 'add_card',to:'customers#add_card'
    get 'user_cards',to:'customers#user_cards'
    get "user_transactions",to:'transactions#user_transactions'
    get 'owner_ernings',to: 'transactions#owner_ernings'
    put 'capture',to:'transactions#capture'
    get 'stripe_payment',to:'customers#stripe_payment'
    get 'success',to:'customers#success'
    get 'fail',to:'customers#fail'
    post 'create_pament_method',to:'customers#create_pament_method'
    get 'payment_check_out',to:'customers#payment_check_out'
  end

  namespace :stripe_intigration do
    get 'send_amount_to_connections',to:'payment_intents#send_amount_to_connections'
    post 'create_connections',to:'connections#create_connections'
    post 'payment_intent',to:'payment_intents#payment_intent'
    post 'payment_refound_with_payment_intent',to:'refunds#payment_refound_with_payment_intent'
    post 'refund_amount_with_charge',to:'refunds#refund_amount_with_charge'
  end

  namespace :comet_chat do 
    get "create_user",to:'chats#create_user'
    get 'add_friends',to:'chats#add_friends'
    get 'send_message',to:'chats#send_message'
    get 'update_group',to:'chats#update_group'
  end

  namespace :faq_block do
    resources :faqs
  end
  namespace :chat_block do
    resources :chats
    resources :messages
  end

  namespace :bus_block do
    resources :buses
  end

  namespace :booking_block do
    resources :bus_bookings
  end
end
