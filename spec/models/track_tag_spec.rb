require 'rails_helper'

RSpec.describe TrackTag, type: :model do
  let(:track_tag) { FactoryBot.create(:track_tag) }

  describe "Validations" do
    it do
      FactoryBot.create(:track_tag)
      should validate_uniqueness_of(:tag_id).scoped_to(:track_id)
    end

    it "is not valid without a track" do
      track_tag.track = nil
      expect(track_tag).to_not be_valid
    end

    it "is not valid without a tag" do
    	track_tag.tag = nil
    	expect(track_tag).to_not be_valid
    end

    it "is valid with a unique (valid tag, valid track) pair" do
    	expect(track_tag).to be_valid
    end

  end
  describe "Associations" do
  	it { should belong_to(:tag) }
  	it { should belong_to(:track) }
  end
end
