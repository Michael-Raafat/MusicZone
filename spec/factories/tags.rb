FactoryBot.define do
  factory :tag do
    value         { Faker::Music.genre }
  end
end
