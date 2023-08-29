require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  before :each do
    @user = User.create(id: 1, name: 'Tom', posts_counter: 3, photo: 'https://pic.com', bio: 'Project manager')
    @user2 = User.create(id: 2, name: 'Jane Smith', posts_counter: 0, photo: 'https://pic.com', bio: 'IT manager')
  end

  scenario 'User can see all users' do
    visit '/'
    expect(page).to have_content('Tom')
    expect(page).to have_content('Jane Smith')
  end

  scenario 'renders the user show page' do
    visit '/'
    click_link(@user.name, match: :first)
    expect(page).to have_content(@user.name)
  end

  scenario 'displays all users profile photo' do
    visit '/'
    expect(page).to have_css(
      "img[src='#{@user.photo}']", wait: 30
    )

    visit '/'
    expect(page).to have_css(
      "img[src='#{@user2.photo}']", wait: 30
    )
  end
end
