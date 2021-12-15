class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :country
      t.string :address
      t.integer :role

      t.timestamps
    end
  end
end
