class UserTag < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :tag, foreign_key: 'tag_id'
  validates_uniqueness_of :tag_id, scope: :user_id
end
