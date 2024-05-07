require 'rails_helper'

RSpec.describe "FaqBlock::Faqs", type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    @token = JwtToken.encode_data(@user)
    @faq = FactoryBot.create(:faq,title:"how are you?",description:"All good", category:"nothing")
    @controller = FaqBlock::FaqsController.new
  end

  describe "GET/index" do
    it "get successfull response if you are avalid user" do
      request.headers['token'] = @token
      get :index
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['data'][0]['title']).to eq(@faq.title)
      expect(JSON.parse(response.body)['message']).to eq("faqs details")
    end
  end

  describe "GET/show" do
    it "returns a successful response when finding a faq" do
      request.headers['token'] = @token
      get :show, params:{id:@faq.id}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['data']['id']).to eq(@faq.id)
      expect(JSON.parse(response.body)['message']).to eq("Faq details")
    end
  end
end
