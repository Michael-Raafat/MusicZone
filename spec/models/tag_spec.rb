require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { described_class.new(genre: "classical") }
  describe "Validations" do
    it "is valid with valid attributes" do
    	expect(subject).to be_valid
    end
    it "is not valid without a genre" do
    	subject.genre = nil
    	expect(subject).to_not be_valid
    end

    it { should validate_uniqueness_of(:genre) }
  end

  describe "Associations" do
  	it { should have_many(:tracks) }
  	it { should have_many(:track_tags) }
  end
end
