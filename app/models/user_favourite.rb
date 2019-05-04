class UserFavourite < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :track, foreign_key: 'track_id'
  validates_uniqueness_of :track_id, scope: :user_id
end
