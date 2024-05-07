require 'rails_helper'

RSpec.feature "AdminUsers", type: :feature do
  let(:admin_user) { FactoryBot.create(:admin_user, email:"hello@gmail.com", password:"123456")}

  before do
    login_as(admin_user, scope: :admin_user)
  end

  describe "AdminUser index page" do
    it "displays admin user details" do
      admin_user = FactoryBot.create(:admin_user, email: "test@example.com",password:"123456" )

      visit admin_admin_users_path

      expect(page).to have_content("test@example.com")
      # expect(page).to have_content(admin_user.current_sign_in_at.strftime("%Y-%m-%d %H:%M:%S"))
      # expect(page).to have_content("1")
      # expect(page).to have_content(admin_user.created_at.strftime("%Y-%m-%d %H:%M:%S"))
    end

    it "allows filtering by email" do
      admin_user = FactoryBot.create(:admin_user, email: "test@example.com",password:"123456")

      visit admin_admin_users_path
      fill_in "Email", with: "test@example.com"
      click_button "Filter"
      expect(page).to have_content("test@example.com")
    end
  end
end
