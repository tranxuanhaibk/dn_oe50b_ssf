class CreateSoccerFields < ActiveRecord::Migration[6.1]
  def change
    create_table :soccer_fields do |t|
      t.string :field_name
      t.integer :type_field
      t.bigint :price
      t.integer :status, default: 0
      t.string :address

      t.timestamps
    end
  end
end
