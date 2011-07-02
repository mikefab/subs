class AddBrowserToTracks < ActiveRecord::Migration
  def self.up
    add_column :tracks, :browser, :string
  end

  def self.down
    remove_column :tracks; :browser
  end
end
