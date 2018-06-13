class CreateGigs < ActiveRecord::Migration[5.1]
  def change
    create_table :gigs do |t|
      t.string :location
      t.string :time
      t.text :description
      t.timestamps
    end
  end
end
