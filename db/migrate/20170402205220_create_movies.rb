class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.date :date
      t.string :type
      t.string :film_time
      t.string :director
      t.text :actor
      t.string :imdb
      t.string :douban

      t.timestamps
    end
  end
end
