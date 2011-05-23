class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.string :search
      t.integer :user_id
      t.string :lang
      t.string :category
      t.integer :page
      t.boolean :option

      t.timestamps
    end
    add_index :searches, :user_id
    add_index :searches, :lang
    add_index :searches, :page
    add_index :searches, :category
    add_index :searches, :option
  end

  def self.down
    drop_table :searches
  end
end
