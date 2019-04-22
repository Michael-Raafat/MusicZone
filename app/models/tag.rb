class Tag < ApplicationRecord
	has_many :track_tags, dependent: :destroy
	has_many :user_tags, dependent: :destroy
	validates_uniqueness_of :value
	validates_presence_of :value
end
