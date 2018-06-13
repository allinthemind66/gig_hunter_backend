class CreateGigApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :gig_applications do |t|
      t.integer :user_id
      t.integer :gig_id
      t.timestamps
    end
  end
end
