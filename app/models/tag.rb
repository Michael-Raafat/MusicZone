class Tag < ApplicationRecord
	has_many :track_tags, dependent: :destroy
	has_many :tracks, :through => :track_tags
	validates_uniqueness_of :genre
	validates_presence_of :genre
end
