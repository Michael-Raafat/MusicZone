class ChangeTagColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :tags, :genre, :value
  end
end
