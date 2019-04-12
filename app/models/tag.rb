class Tag < ApplicationRecord
	has_many :track_tags
	has_many :tracks, :through => :track_tags
end
