class CreateRoots < ActiveRecord::Migration
  def self.up
    create_table :roots do |t|
      t.string :verb
      t.string :trans
      t.string :kind

      t.timestamps
    end
  end

  def self.down
    drop_table :roots
  end
end
