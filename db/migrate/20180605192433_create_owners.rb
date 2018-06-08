class CreateOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :owners do |t|
      t.string :name
      t.timestamps
    end
    change_table :units do |t|
      t.references :owner, null: false
    end
  end
end
