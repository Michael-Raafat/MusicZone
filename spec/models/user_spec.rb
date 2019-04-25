require 'rails_helper'

RSpec.describe User, type: :model do
  user = FactoryBot.build(:user)
  describe "Validations" do
    it "is valid with valid attributes" do
    	expect(user).to be_valid
    end
    it "is not valid without a first name" do
    	user.first_name = nil
    	expect(user).to_not be_valid
    end

    it "is not valid without a last name" do
    	user.last_name = nil
    	expect(user).to_not be_valid
    end

    it "is not valid without first and last name" do
    	user.first_name = nil
    	user.last_name = nil
    	expect(user).to_not be_valid
    end

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe "Associations" do
  	it { should have_many(:tags) }
  	it { should have_many(:user_tags) }
  end
end
