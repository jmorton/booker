# This migration adds constraints to reservations that prevent the same unit
# from being booked simultaneously.
#

class ReservationConstraints < ActiveRecord::Migration[5.2]

  def up

    execute <<-SQL
      CREATE EXTENSION btree_gist
    SQL

    execute <<-SQL
      ALTER TABLE reservations
      ADD CONSTRAINT no_unit_during
      EXCLUDE USING gist (unit_id WITH = , during WITH &&)
    SQL

  end

  def down

    execute <<-SQL
      DROP EXTENSION btree_gist
    SQL

    execute <<-SQL
      ALTER TABLE reservations
      DROP CONSTRAINT no_unit_during
    SQL

  end

end
