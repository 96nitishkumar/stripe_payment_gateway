require 'rails_helper'

RSpec.describe "Bookings", type: :request do
  before(:each) do
    @user = FactoryBot.create(:user,email: "hello@gamil.com", password: "123456", device_token: "kjdslfkjdsljfdkfldjfldfjlkdf")
    @user_1 = FactoryBot.create(:user,email: "hello1@gamil.com", password: "123456", device_token: "kjdslfkjdsljfdkfldjfldfjlkdf")
    @room = FactoryBot.create(:room,user_id: @user.id,max_days:234,status: "Accept")
    @room_1 = FactoryBot.create(:room,user_id: @user.id,max_days:234,status: "Accept")
    @booking = FactoryBot.create(:booking,user_id: @user_1.id, room_id: @room.id,from_date:"21-02-2024",to_date: "23-02-2024")
    @token = JwtToken.encode_data(@user_1)
    @token_1 = JwtToken.encode_data(@user)

    @valid_params = {
      booking:{
        from_date:"21-02-2024",
        to_date: "23-02-2024",
        room_id: @room_1.id
      }
    }
    @invalid_params = {
      booking:{
        from_date:"21-02-2024",
        to_date: "23-02-2024"
      }
    }
  end

  describe "GET /index" do
    it "returns a successful response when finding users" do
      get "/bookings/#{@booking.id}", headers: {token: @token }
      expect(response).to have_http_status(200)
      
      expect(JSON.parse(response.body)["message"]).to eq("Booking Details")
    end
    it "returns a successful response when finding users" do
      get "/bookings", headers: {token: @token }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("All bookings Details")
    end
  end
  describe "POST /create" do
    it "returns a created response when entering valid user parameters" do
      post "/bookings", headers: {token: @token },params: @valid_params
      expect(response).to have_http_status(200)
      # expect(JSON.parse(response.body)["data"]["data"]["attributes"]["email"]). to eq("nithin@gamil.com")
      expect(JSON.parse(response.body)["message"]).to eq("Booking created")
    end
    it "returns a created response when entering valid user parameters" do
      post "/bookings",headers: {token: @token }, params: @invalid_params
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["message"]).to eq("Booking creation fails")
    end
  end

  describe "PUT /UPDATE" do
    it "returns a successful response when booking is updated" do
      put "/bookings/#{@booking.id}", headers: {token: @token },params: @valid_params
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Booking updated")
    end
    it "returns a successful response when booking is updated" do
      put "/bookings/#{@booking.id}",headers: {token: @token }, params: {booking: {room_id:nil}}
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["message"]).to eq("Booking not updated")
    end
  end

  describe "DELETE /destroy" do
    it "returns a successful response when booking is present" do
      delete "/bookings/#{@booking.id}", headers: {token: @token }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Booking deleted")
    end
  end

  describe "GET / USER BOOKINGS" do 
    it "returns a successful response when user present" do
      get "/user_bookigs" ,headers:{token: @token}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eq("User Bookings")
    end

    it "returns a successful response when user present" do
      get "/owner_bookings", headers:{token: @token}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eq("Owner Bookings")
    end

    it "returns a successful response when user present" do
      get "/owner_feature_bookings" ,headers:{token: @token}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eq("Owner feature bookings")
    end

    it "returns a successful response when user present" do
      get "/user_feature_bookings" ,headers:{token: @token}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eq("User feature  Bookings")
    end
  end

  describe "PATCH/update_owner" do
    it "returns a successful response when booking is updated" do
      patch"/update_owner",params:{id:@booking.id,booking:{status:"Accept"}},headers:{token:@token_1}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eq("Booking updated")
    end

    it "returns a successful response when booking is updated" do
      patch"/update_owner",params:{id:@booking.id,booking:{status:"Accept_1"}},headers:{token:@token_1}
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)['message']).to eq("Booking not updated")
    end

    it "returns a successful response when booking is updated" do
      patch"/update_owner",params:{booking:{id:@booking.id,status:"Accept"}},headers:{token:@token}
      expect(response).to have_http_status(422)
      # debugger
      expect(JSON.parse(response.body)['error']).to eq("ActiveRecord::RecordNotFound")
      expect(JSON.parse(response.body)['message']).to eq("Your not available to Accept or Reject")
    end
  end

  describe 'PATCH/cancel booking' do
    it "returns a successful response when booking is updated" do
      patch '/cancel_booking', params:{id:@booking.id},headers:{token:@token}
      expect(response).to have_http_status(200)
      # debugger
      expect(JSON.parse(response.body)['data']['data']['attributes']['status']).to eq('Cancel')
    end
  end
end
