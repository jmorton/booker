class GeocodeUnit < ActiveRecord::Migration[5.2]

  def up
    add_column :units, :address, :string
    add_column :units, :latitude, :float
    add_column :units, :longitude, :float
  end

  def down
    remove_colunn :units, :address
    remove_column :units, :latitude
    remove_column :units, :longitude
  end

end
