require 'rails_helper'

RSpec.describe Track, type: :model do
  #let(:user) { AdminUser.new(:email => "jane@doe.com", :password => "pw1234",
  #                     :password_confirmation => "pw1234") }
  subject { described_class.new(title: "sweet amr music", audio: "path\\to\\sweet\\amr\\music") }#, admin_user: user) }

  describe "Validations" do
	  it "is valid with valid attributes" do
	  	expect(subject).to be_valid
	  end

	  #it { should validate_presence_of(:admin_user) }
	  
	  it "is not valid without a title" do
	  	subject.title = nil
	  	expect(subject).to_not be_valid
	  end
	  
	  it "is not valid without an audio" do
	  	subject.audio = nil
	  	expect(subject).to_not be_valid
	  end
	  
	  it { should validate_uniqueness_of(:title) }
  end

  describe "Associations" do
  	#it { should belong_to(:admin_user) }
  	it { should have_many(:tags) }
  end
end
