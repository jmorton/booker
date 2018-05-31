class CreateReservations < ActiveRecord::Migration[5.2]

  def up
    create_table :reservations do |t|
      t.references :unit, null: false
      t.references :guest, null: false
      t.column     :start_at, 'timestamp with time zone', null: false
      t.column     :end_at, 'timestamp with time zone', null: false
      t.timestamps
    end
    add_foreign_key :reservations, :units
    add_foreign_key :reservations, :guests
  end

  def down
    drop_table :reservations
  end

end
