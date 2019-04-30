FactoryBot.define do
  factory :user_tag do
    user { create(:user) }
    tag { create(:tag) }
  end
end
