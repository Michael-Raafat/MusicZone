class Track < ActiveRecord::Base
  belongs_to :admin_user
  has_many :track_tags
  has_many :tags, :through => :track_tags
  validates_presence_of :title, :admin_user, :audio
  validates_uniqueness_of :title
  mount_uploader :audio, AudioUploader
end
