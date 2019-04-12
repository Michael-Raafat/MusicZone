class AddAudioToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :audio, :string
  end
end
