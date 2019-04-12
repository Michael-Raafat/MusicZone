require 'rails_helper'

RSpec.describe Tag, type: :model do
  tag = FactoryBot.build(:tag)

  describe "Validations" do
    it "is valid with valid attributes" do
    	expect(tag).to be_valid
    end
    it "is not valid without a value" do
    	tag.value = nil
    	expect(tag).to_not be_valid
    end

    it { should validate_uniqueness_of(:value) }
    it { should validate_presence_of(:value) }
  end

  describe "Associations" do
  	it { should have_many(:tracks) }
  	it { should have_many(:track_tags) }
  end
end
