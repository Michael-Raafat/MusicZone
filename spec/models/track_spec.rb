require 'rails_helper'

RSpec.describe Track, type: :model do
  valid_track = FactoryBot.build(:track)

  describe "Validations" do
	  it "is valid with valid attributes" do
	  	expect(valid_track).to be_valid
	  end

	  it { should validate_presence_of(:admin_user) }

	  it "is not valid without a title" do
	  	valid_track.title = nil
	  	expect(valid_track).to_not be_valid
	  end

	  it { should validate_uniqueness_of(:title) }
	  it { should validate_presence_of(:title) }
  end

  describe "Associations" do
  	it { should belong_to(:admin_user) }
  	it { should have_many(:tags) }
  	it { should have_many(:track_tags) }
  end
end
