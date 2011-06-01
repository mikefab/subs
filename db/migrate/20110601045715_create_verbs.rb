class CreateVerbs < ActiveRecord::Migration
  def self.up
    create_table :verbs do |t|
      t.string :verb
      t.string :conj
      t.string :mood
      t.string :tense
      t.string :tense_type
      t.string :pro
      t.string :pre

      t.timestamps
    end
    add_index :verbs, :verb
    add_index :verbs, :conj

  end

  def self.down
    drop_table :verbs
  end
end
