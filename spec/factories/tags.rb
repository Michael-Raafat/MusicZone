FactoryBot.define do
  factory :tag do
    value         { Faker::Music.genre + Faker::Name.unique.name }
  end
end
