require 'spec_helper'

describe "Static pages" do

   let(:base_title) { "Mini Legions" }
  #Home is the one static page that has been streamlined
  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      expect(page).to have_title("Mini Legions")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      expect(page).not_to have_title('| Home')
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "should have the base title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Mini Legions")
    end

    it "should not have a custom page title" do
      visit '/static_pages/help'
      expect(page).not_to have_title('| Help')
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("#{base_title} | About Us")
    end
  end

  describe "Contact page" do

    it "should have the content 'Contact Us'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact Us')
    end

    it "should have the title 'Contact Us'" do
      visit '/static_pages/contact'
      expect(page).to have_title("#{base_title} | Contact Us")
    end
  end

  describe "Signup page" do

    it "should have the content 'Sign Up'" do
      visit '/static_pages/signup'
      expect(page).to have_content('Sign Up')
    end

    it "should have the title 'Sign Up'" do
      visit '/static_pages/signup'
      expect(page).to have_title("#{base_title} | Sign Up")
    end
  end

  describe "Test" do

    it "should have the content 'Test'" do
      visit '/static_pages/test'
      expect(page).to have_content('Test')
    end

    it "should have the title 'Test'" do
      visit '/static_pages/test'
      expect(page).to have_title("#{base_title} | Test")
    end
  end

end