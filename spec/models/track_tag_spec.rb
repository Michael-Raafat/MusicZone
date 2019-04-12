require 'rails_helper'

RSpec.describe TrackTag, type: :model do
  let(:user) { AdminUser.new(:email => "jane@doe.com", :password => "pw1234",
                       :password_confirmation => "pw1234") }
  let(:track) { Track.new(title: "sweet amr music", audio: "path\\to\\sweet\\amr\\music", admin_user: user) }
  let(:tag) { Tag.new(genre: "classical") }
  subject { described_class.new(tag: tag, track: track) }
  describe "Validations" do
    it "is not valid without a track" do
      subject.track = nil
      expect(subject).to_not be_valid
    end
    it "is not valid without a tag" do
    	subject.tag = nil
    	expect(subject).to_not be_valid
    end
    it "is valid with a unique (valid tag, valid track) pair" do
    	expect(subject).to be_valid
    end
    it { should validate_uniqueness_of(:tag_id).scoped_to(:track_id) }
  end
  describe "Associations" do
  	it { should belong_to(:tag) }
  	it { should belong_to(:track) }
  end
end
