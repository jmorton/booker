class AddUnitDetail < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'citext' # important for case insensitive queries

    # Used to store results from the Geocoder
    add_column :units, :location, :jsonb, null: false, default: {}
    add_index  :units, :location, using: :gin

    # Used to store information about a unit's features.
    add_column :units, :detail, :jsonb, null: false, default: {}
    add_index  :units, :detail, using: :gin

    # NOTE: Use this to create an index for a path within a JSONB column.
    # execute <<-SQL
    #   CREATE INDEX units_detail_ix ON units ((detail->>'price'))
    # SQL

  end
end
