require 'rails_helper'

RSpec.describe TrackTag, type: :model do
  it "is not valid without a track"
  it "is not valid without a tag"
  it "is not valid without a valid track"
  it "is not valid without a valid tag"
  it "is not valid without a valid track and a valid tag"
  it "is valid with a unique (valid tag, valid track) pair"
  it "is valid with a valid unique tag and a valid repeated track pair"
  it "is valid with a valid repeated tag and a valid unique track pair"
  it "is not valid with a repeated tag and track pair"
end
