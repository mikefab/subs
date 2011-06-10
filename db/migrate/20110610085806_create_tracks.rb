class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :ip
      t.string :search
      t.string :lang
      t.string :page
      t.integer :num

      t.timestamps
    end
        add_index :tracks, :ip
        add_index :tracks, :lang

  end

  def self.down
    drop_table :tracks
  end
end
