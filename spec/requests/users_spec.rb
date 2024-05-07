require 'rails_helper'

RSpec.describe "Users", type: :request do
    before(:each) do
    @user = FactoryBot.create(:user,email: "hello@gamil.com", password: "123456")
    @token = JwtToken.encode_data(@user)
    @valid_params = {
      user: {
        name: "nithin",
        email:"nithin@gamil.com",
        phone_number: "9658965896",
        password: "password" 
      }
    }
    @invalid_params = {
      user: {
        name: "nithin",
        phone_number: "9658965896",
        password: "password" 
      }
    }
  end

  describe "GET /index" do
    it "returns a successful response when finding users" do
      get "/users", headers: {token: @token }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("User list")
    end
  end
  describe "POST /create" do
    it "returns a created response when entering valid user parameters" do
      post "/signup", params: @valid_params
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["data"]["data"]["attributes"]["email"]). to eq("nithin@gamil.com")
      expect(JSON.parse(response.body)["message"]).to eq("User created")
    end
    it "returns a created response when entering valid user parameters" do
      post "/signup", params: @invalid_params
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["message"]).to eq("User creation fails")
    end
  end

  describe "POST/ login" do
    it "returns a successful response when entering valid user parameters" do
      post "/login", params:{email: @user.email, password: @user.password}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['data']['data']['attributes']['email']). to eq(@user.email)
      expect(JSON.parse(response.body)["message"]).to eq("User login")
    end

    it "returns a successful response when entering valid user parameters" do
      post "/login", params:{email: @user.email}
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["message"]).to eq("Invalid creadentials")
    end
  end

end
