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

    let(:new_name)  { "New Name" }
    let(:new_email) { "new@example.com" }
    let(:user_password) { "foobar" }
    let(:user_password_confirmation) { "foobar" }
    
    before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user_password
        fill_in "Password Confirmation", with: user_password_confirmation
        click_button "Sign in"
      end
      
      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
      end
    end 
  end
