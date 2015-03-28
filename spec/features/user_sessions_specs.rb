require 'rails_helper'


feature 'user registers' do
  context "with valid input" do
    scenario 'it creates a new user' do
      register_new_user
      expect(page).to have_content 'Logged in as test@test.com'
    end
  end

  context 'with invalid input' do
    scenario 'it does not create a new user' do
      go_home
      click_link "Register"
      fill_in "Email", with: ''
      fill_in "Password", with: 'password'
      fill_in "Password confirmation", with: 'password'
      click_on "Sign up"
      expect(page).to_not have_content 'Logged in as test@test.com'
    end
  end
end

feature 'user logs in and out' do
  scenario 'user logs out and in' do
    register_new_user
    click_link "Sign out"

    expect(page).to have_content "Signed out successfully."

    click_link 'Sign in'
    fill_in "Email", with: 'test@test.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
