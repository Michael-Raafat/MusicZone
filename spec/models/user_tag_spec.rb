require 'rails_helper'

RSpec.describe UserTag, type: :model do
  let(:user_tag) { FactoryBot.create(:user_tag) }
  describe "Validations" do
  	it do
      FactoryBot.create(:user_tag)
      should validate_uniqueness_of(:tag_id).scoped_to(:user_id)
    end
  end
  describe "Associations" do
  	it { should belong_to(:tag) }
  	it { should belong_to(:user) }
  end
end
