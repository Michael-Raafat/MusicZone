require 'rails_helper'

def login_via_form(email, password)
  expect(page).to have_current_url("/users/sign_in")
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Sign in"
end

describe "User operations", type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }

  it "registers a new user" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: valid_attributes[:email]
    fill_in "Password", with: valid_attributes[:password]
    fill_in "Confirm Password", with: valid_attributes[:password]
    fill_in "First Name", with: valid_attributes[:first_name]
    fill_in "Last Name", with: valid_attributes[:last_name]
    click_button "Sign up"
    expect(page).to have_content "Logged in as #{valid_attributes[:email]}"
  end

  it "registers a new user without first name" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: valid_attributes[:email]
    fill_in "Password", with: valid_attributes[:password]
    fill_in "Confirm Password", with: valid_attributes[:password]
    fill_in "First Name", with: nil
    fill_in "Last Name", with: valid_attributes[:last_name]
    click_button "Sign up"
    expect(page).to have_content "error prohibited this user from being saved"
  end

  it "registers two users with same credentials" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: valid_attributes[:email]
    fill_in "Password", with: valid_attributes[:password]
    fill_in "Confirm Password", with: valid_attributes[:password]
    fill_in "First Name", with: valid_attributes[:first_name]
    fill_in "Last Name", with: valid_attributes[:last_name]
    click_button "Sign up"
    expect(page).to have_content "Logged in as #{valid_attributes[:email]}"
    click_link("Logout", match: :first)
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: valid_attributes[:email]
    fill_in "Password", with: valid_attributes[:password]
    fill_in "Confirm Password", with: valid_attributes[:password]
    fill_in "First Name", with: valid_attributes[:first_name]
    fill_in "Last Name", with: valid_attributes[:last_name]
    click_button "Sign up"
    expect(page).to have_content "error prohibited this user from being saved"
  end

  it "log in unregistered user" do
    visit "/"
    fill_in "Email", with: valid_attributes[:email]
    fill_in "Password", with: valid_attributes[:password]
    click_button "Log in"
    expect(page).to_not have_content "Logged in as #{valid_attributes[:email]}"
  end

  it "log in registered user" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: valid_attributes[:email]
    fill_in "Password", with: valid_attributes[:password]
    fill_in "Confirm Password", with: valid_attributes[:password]
    fill_in "First Name", with: valid_attributes[:first_name]
    fill_in "Last Name", with: valid_attributes[:last_name]
    click_button "Sign up"
    expect(page).to have_content "Logged in as #{valid_attributes[:email]}"
    click_link("Logout", match: :first)
    visit "/"
    fill_in "Email", with: valid_attributes[:email]
    fill_in "Password", with: valid_attributes[:password]
    click_button "Log in"
    expect(page).to have_content "Logged in as #{valid_attributes[:email]}"
  end
end