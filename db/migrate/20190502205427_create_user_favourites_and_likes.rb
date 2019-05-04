class CreateUserFavouritesAndLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_favourites do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :track, foreign_key: true

      t.timestamps
    end

    create_table :user_likes do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :track, foreign_key: true

      t.timestamps
    end
  end
end
