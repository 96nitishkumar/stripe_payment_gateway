class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,:name, :email, :phone_number, :device_token
end
