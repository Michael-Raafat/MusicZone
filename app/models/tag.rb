class Tag < ApplicationRecord
	has_many :track_tags, dependent: :destroy
	has_many :tracks, :through => :track_tags
	validates_uniqueness_of :value
	validates_presence_of :value
end
