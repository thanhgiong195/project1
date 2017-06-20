class AddPictureToAuthorposts < ActiveRecord::Migration[5.1]
  def change
    add_column :authorposts, :picture, :string
  end
end
