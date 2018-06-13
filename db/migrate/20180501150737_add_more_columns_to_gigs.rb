class AddMoreColumnsToGigs < ActiveRecord::Migration[5.1]
  def change
    add_column :gigs, :venue, :string
    add_column :gigs, :pay, :integer
    add_column :gigs, :rehearsals, :integer
    add_column :gigs, :concert_dress, :string
    add_column :gigs, :style, :string
  end
end
