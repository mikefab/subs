class AddHideToCaps < ActiveRecord::Migration
  def self.up
    add_column :caps, :hide, :boolean
    add_index :caps, :hide
  end

  def self.down
    remove_column :caps, :hide
  end
end
