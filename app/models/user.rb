class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_tags, dependent: :destroy
  has_many :tags, :through => :user_tags

  has_many :user_favourites, dependent: :destroy
  has_many :favourites, through: :user_favourites, source: :track

  has_many :user_likes, dependent: :destroy
  has_many :likes, through: :user_likes, source: :track

  validates_presence_of :first_name, :last_name

  def set_user_tags(ids)
    tags = Tag.find(ids)
    self.tags = tags
    self.save
  end

  def swap_track_liked(tracks)
    if self.likes.where(id: tracks.ids).empty?
      self.likes << tracks
    else
      self.likes.delete(tracks)
    end
    self.save
  end

  def swap_track_favourites(tracks)
    if self.favourites.where(id: tracks.ids).empty?
      self.favourites << tracks
    else
      self.favourites.delete(tracks)
    end
    self.save
  end
end
