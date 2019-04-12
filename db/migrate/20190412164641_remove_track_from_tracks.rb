class RemoveTrackFromTracks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tracks, :track, :text
  end
end
