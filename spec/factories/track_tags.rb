FactoryBot.define do
  factory :track_tag do
    tag     { create(:tag) }
    track   { create(:track) }
  end
end
