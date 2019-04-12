class RemovePathFromTracks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tracks, :path, :text
  end
end
