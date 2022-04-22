require 'rails_helper'

RSpec.describe "Translation", type: :system do
  before do
    driven_by(:rack_test)
  end

  context "Switch languages" do 
      
    it "should switch to arabic" do
      visit users_path
      click_link "En"
  
      expect(page).to have_text "العربية"
    end

    it "should switch to english" do
      visit users_path
      click_link "العربية"
      expect(page).to have_text "En"
    end
  end


end
