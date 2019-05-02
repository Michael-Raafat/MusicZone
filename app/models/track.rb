class Track < ActiveRecord::Base
  belongs_to :admin_user
  has_many :track_tags, dependent: :destroy
  has_many :tags, :through => :track_tags

  has_many :user_likes, dependent: :destroy
  has_many :user_favourites, dependent: :destroy

  validates_presence_of :title, :admin_user
  validates_uniqueness_of :title
  mount_uploader :audio, AudioUploader
end
