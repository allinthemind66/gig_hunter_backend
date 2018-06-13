class CreateUserInstruments < ActiveRecord::Migration[5.1]
  def change
    create_table :user_instruments do |t|
      t.belongs_to :user, index: true
      t.belongs_to :instrument, index: true
      t.timestamps
    end
  end
end
