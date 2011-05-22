class CreateCaps < ActiveRecord::Migration
  def self.up
    create_table :caps do |t|
      t.integer :num
      t.string :spa
      t.string :eng
      t.string :por
      t.string :rus
      t.string :man
      t.string :fre
      t.string :start
      t.string :stop
      t.string :url
      t.string :lang
      t.string :source
      t.string :source2            
      t.integer :wcount
      t.integer :ccount

      t.timestamps
    end
    add_index :caps, :wcount
    add_index :caps, :start
    add_index :caps, :stop
    add_index :caps, :num
    add_index :caps, :spa
    add_index :caps, :eng
    add_index :caps, :por
    add_index :caps, :man
    add_index :caps, :fre
    add_index :caps, :rus
    add_index :caps, :lang
    add_index :caps, :url
    add_index :caps, :source
  end

  def self.down
    drop_table :caps
  end
end
