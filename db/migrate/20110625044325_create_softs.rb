class CreateSofts < ActiveRecord::Migration
  def self.up
    create_table :softs do |t|
      t.string :text
      t.integer :cap_id
      t.string :lang
      t.string :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :softs
  end
end
