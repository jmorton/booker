class CreateReservations < ActiveRecord::Migration[5.2]

  def up
    create_table :reservations do |t|
      t.references :unit, null: false
      t.references :guest, null: false
      t.date :start_at, null: false
      t.date :end_at, null: false
      t.timestamps
    end
    add_foreign_key :reservations, :units
    add_foreign_key :reservations, :guests
  end

  def down
    drop_table :reservations
  end

end
