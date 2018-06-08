class CreateIdentities < ActiveRecord::Migration[5.2]
  def change

    create_table :identities do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.jsonb  :info
      t.jsonb  :credentials
      t.jsonb  :extra
      t.timestamps
    end

    add_index :identities, [:provider, :uid], unique: true

    change_table :guests do |t|
      t.references :identity, foreign_key: {on_delete: :nullify}
    end

    change_table :owners do |t|
      t.references :identity, foreign_key: {on_delete: :nullify}
    end

  end
end
