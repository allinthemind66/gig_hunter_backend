class AddPhotoUrlToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :img_url, :string
  end
end
