FactoryBot.define do
  factory :track do
    admin_user     { create(:admin_user) }
    title          { |n| Faker::Music.album  + " (#{n})"}
  end
end
