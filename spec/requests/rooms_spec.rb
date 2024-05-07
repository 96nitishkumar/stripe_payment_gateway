require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  before(:each) do
    @user = FactoryBot.create(:user,email: "hello@gamil.com", password: "123456")
    @room = FactoryBot.create(:room,user_id: @user.id)
    @token = JwtToken.encode_data(@user)
    @valid_params = {
      room: {
        name: "hello_hotel",
        price:1000,
        location: "Hyd",
        max_days: 4 
      }
    }
    @invalid_params = {
      room: {
        name: "hello_hotel",
        location: "Hyd",
        max_days: 4 
      }
    }
  end

  describe "GET /index" do
    it "returns a successful response when finding users" do
      get "/rooms/#{@room.id}", headers: {token: @token }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Room Details")
    end
    it "returns a successful response when finding users" do
      get "/rooms", headers: {token: @token }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("All Room Details")
    end
  end
  describe "POST /create" do
    it "returns a created response when entering valid user parameters" do
      post "/rooms", headers: {token: @token },params: @valid_params
      expect(response).to have_http_status(200)
      # expect(JSON.parse(response.body)["data"]["data"]["attributes"]["email"]). to eq("nithin@gamil.com")
      expect(JSON.parse(response.body)["message"]).to eq("Room created")
    end
    it "returns a created response when entering valid user parameters" do
      post "/rooms",headers: {token: @token }, params: @invalid_params
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["message"]).to eq("Room creatation fails")
    end
  end

  describe "PUT /UPDATE" do
    it "returns a created response when entering valid user parameters" do
      put "/rooms/#{@room.id}", headers: {token: @token },params: @valid_params
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Room updated")
    end
    it "returns a created response when entering valid user parameters" do
      put "/rooms/#{@room.id}",headers: {token: @token }, params: {room: {price:nil}}
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["message"]).to eq("Room not updated")
    end
  end

  describe "DELETE /destroy" do
    it "returns a created response when entering valid user parameters" do
      delete "/rooms/#{@room.id}", headers: {token: @token }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Room deleted")
    end
  end

  describe "GET/ user properties" do 
    it "returns a successful response when user present" do 
      get "/user_properties", headers:{token:@token}
      expect(response).to have_http_status(200)
      token = JwtToken.decode_data(@token)
      id = token[0]["id"]
      @current_user = User.find(id)
      expect(JSON.parse(response.body)["message"]).to eq("#{@current_user.name} Rooms")
    end

    it "returns a successful response when user present" do 
      get "/properties", headers:{token:@token}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("All properties details")
    end
  end
end
