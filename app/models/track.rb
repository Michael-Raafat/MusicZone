class Track < ApplicationRecord
  belongs_to :admin_user
  has_many :track_tags
  has_many :tags, :through => :track_tags
  validates_presence_of :title, :path, :admin_user
  validates_uniqueness_of :title

end
