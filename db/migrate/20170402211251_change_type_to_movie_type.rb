class ChangeTypeToMovieType < ActiveRecord::Migration[5.0]
  def change
    rename_column :movies, :type, :film_type
  end
end
