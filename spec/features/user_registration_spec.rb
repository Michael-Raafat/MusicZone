require 'rails_helper'

def login_via_form(email, password)
  expect(page).to have_current_url("/users/sign_in")
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Sign in"
end

describe "User registration", type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }

  it "register without providing any field" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: nil
    fill_in "Password", with: nil
    fill_in "Confirm Password", with: nil
    fill_in "First Name", with: nil
    fill_in "Last Name", with: nil
    click_button "Sign up"
    expect(page).to have_content "errors prohibited this user from being saved"
  end

  it "register a user without providing an email" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: nil
    fill_in "Password", with: valid_attributes[:password]
    fill_in "Confirm Password", with: valid_attributes[:password]
    fill_in "First Name", with: valid_attributes[:first_name]
    fill_in "Last Name", with: valid_attributes[:last_name]
    click_button "Sign up"
    expect(page).to have_content "error prohibited this user from being saved"
  end

  it "register a user without providing a password" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: valid_attributes[:email]
    fill_in "Password", with: nil
    fill_in "Confirm Password", with: valid_attributes[:password]
    fill_in "First Name", with: valid_attributes[:first_name]
    fill_in "Last Name", with: valid_attributes[:last_name]
    click_button "Sign up"
    expect(page).to have_content "errors prohibited this user from being saved"
  end

  it "register a user without providing a first name" do
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

  it "register a user without providing a last name" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: valid_attributes[:email]
    fill_in "Password", with: valid_attributes[:password]
    fill_in "Confirm Password", with: valid_attributes[:password]
    fill_in "First Name", with: valid_attributes[:first_name]
    fill_in "Last Name", with: nil
    click_button "Sign up"
    expect(page).to have_content "error prohibited this user from being saved"
  end

  it "register a new user with invalid email format" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: valid_attributes[:first_name]
    fill_in "Password", with: valid_attributes[:password]
    fill_in "Confirm Password", with: valid_attributes[:password]
    fill_in "First Name", with: valid_attributes[:first_name]
    fill_in "Last Name", with: valid_attributes[:last_name]
    click_button "Sign up"
    expect(page).to have_content "error prohibited this user from being saved"
  end

  it "register two users with same credentials" do
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

  it "register two users with same credentials with different emails" do
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
    fill_in "Email", with: "uni_" + valid_attributes[:email]
    fill_in "Password", with: valid_attributes[:password]
    fill_in "Confirm Password", with: valid_attributes[:password]
    fill_in "First Name", with: valid_attributes[:first_name]
    fill_in "Last Name", with: valid_attributes[:last_name]
    click_button "Sign up"
    expect(page).to have_content "Logged in as uni_#{valid_attributes[:email]}"
  end
  
  it "register a new user with non-matching passwords" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: valid_attributes[:email]
    fill_in "Password", with: valid_attributes[:password]
    fill_in "Confirm Password", with: "a" + valid_attributes[:password]
    fill_in "First Name", with: valid_attributes[:first_name]
    fill_in "Last Name", with: valid_attributes[:last_name]
    click_button "Sign up"
    expect(page).to have_content "error prohibited this user from being saved"
  end

  it "register a new user" do
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

end

describe "User login", type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }

  it "log in unregistered user" do
    visit "/"
    fill_in "Email", with: valid_attributes[:email]
    fill_in "Password", with: valid_attributes[:password]
    click_button "Log in"
    expect(page).to_not have_content "Logged in as #{valid_attributes[:email]}"
  end

  it "log in without email and password" do
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
    fill_in "Email", with: nil
    fill_in "Password", with: nil
    click_button "Log in"
    expect(page).to_not have_content "Logged in as #{valid_attributes[:email]}"
  end

  it "log in without email" do
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
    fill_in "Email", with: nil
    fill_in "Password", with: valid_attributes[:password]
    click_button "Log in"
    expect(page).to_not have_content "Logged in as #{valid_attributes[:email]}"
  end

  it "log in without password" do
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
    fill_in "Password", with: nil
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

  it "log in registered user with wrong password" do
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
    fill_in "Password", with: valid_attributes[:password] + "wrong"
    click_button "Log in"
    expect(page).to_not have_content "Logged in as #{valid_attributes[:email]}"
  end
end