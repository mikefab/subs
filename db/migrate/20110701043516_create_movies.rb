class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :title
      t.string :origin

      t.timestamps
    end
    add_index :movies, :title
    add_index :movies, :origin
    
  end

  def self.down
    drop_table :movies
  end
end
