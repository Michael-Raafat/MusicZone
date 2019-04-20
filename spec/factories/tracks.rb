FactoryBot.define do
  factory :track do
    admin_user     { create(:admin_user) }
    title          { Faker::Music::RockBand.name }
  end
end
