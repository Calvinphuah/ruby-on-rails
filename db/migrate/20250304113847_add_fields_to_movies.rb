
class AddFieldsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :director, :string
    add_column :movies, :genres, :string, array: true, default: []
    add_column :movies, :release_date, :date
    add_column :movies, :score, :integer
    add_column :movies, :status, :string, default: "Upcoming"
  end
end

