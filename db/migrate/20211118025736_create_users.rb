class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :country
      t.string :address
      t.string :provider
      t.string :uid
      t.integer :role, null: false, default: 0

      t.timestamps
    end
  end
end
