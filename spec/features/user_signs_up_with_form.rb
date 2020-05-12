require 'rails_helper'

RSpec.feature 'User signs up using the register form' do
    scenario 'they are able to log in' do
        # Variable setup
        user_fullname = 'Michael Shepherd'
        user_username = 'michaelshepherd'
        user_email = 'm@gmail.com'
        user_password = '123456'
        user_password_confirmation = '123456'

        # Capybara instructions
        visit root_path
        click_on 'Sign up'
        fill_in 'user_fullname', with: user_fullname
        fill_in 'user_username', with: user_username
        fill_in 'user_email', with: user_email
        fill_in 'user_password', with: user_password
        fill_in 'user_password_confirmation', with: user_password_confirmation
        click_button 'Sign up'

        # Assertions
        expect(page).to have_content(user_fullname)
    end
end