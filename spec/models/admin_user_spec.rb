require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe "Associations" do
  	it { should have_many(:tracks) }
  end
end
