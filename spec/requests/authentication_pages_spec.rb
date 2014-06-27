require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin" do

    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in"}

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
       end
    end

  describe "with valid information" do
    let(:user) { FactoryGirl.create(:user) }
    
    before do
        fill_in "Name", with: user.name
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        fill_in "Password Confirmation", with: user.password_confirmation
        click_button "Sign in"
      end
      
      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      end
    end 
  end
