class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.string :verb
      t.string :mood
      t.string :tense
      t.string :trans
      t.integer :verb_id

      t.timestamps
    end
    add_index :translations, :verb
    add_index :translations, :mood
    add_index :translations, :tense
    add_index :translations, :verb_id

  end

  def self.down
    drop_table :translations
  end
end
