class RemoveImageFromMovies < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :image_file_name, :string
  end
end
