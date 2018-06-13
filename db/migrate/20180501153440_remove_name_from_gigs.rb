class RemoveNameFromGigs < ActiveRecord::Migration[5.1]
  def change
    remove_column :gigs, :name
  end
end
