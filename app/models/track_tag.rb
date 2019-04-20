class TrackTag < ApplicationRecord
  belongs_to :track, foreign_key: 'track_id'
  belongs_to :tag, foreign_key: 'tag_id'
  validates_uniqueness_of :tag_id, scope: :track_id
end
