require 'rails_helper'

RSpec.feature 'User submits a listing' do
    scenario 'they see the page for the submitted listing' do
        # Variable setup
        listing_title = 'Vintage synthesizer'
        listing_price = 1000
        listing_description = '80s analog synth'
        user = User.create(email: 'test@test.com', password: '123456', fullname: 'Test User', username: 'test_User', bio: 'a description about the test user goes here', is_admin: nil)
        login_as user, scope: :user

        # Capybara instructions
        visit root_path
        click_on 'Post an item'
        fill_in 'listing_title', with: listing_title
        fill_in 'listing_price', with: listing_price
        fill_in 'listing_description', with: listing_description
        click_on 'Submit'

        # Assertions
        expect(page).to have_content(listing_title)
    end
end