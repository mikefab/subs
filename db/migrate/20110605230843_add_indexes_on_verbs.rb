class AddIndexesOnVerbs < ActiveRecord::Migration
  def self.up
    add_index :verbs, :tense
    add_index :verbs, :mood
    add_index :verbs, :pre

  end

  def self.down
  end
end
