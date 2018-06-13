class AddDateAndNameAndGroupToGigsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :gigs, :date, :date
    add_column :gigs, :name, :string
    add_column :gigs, :group, :string
  end
end
