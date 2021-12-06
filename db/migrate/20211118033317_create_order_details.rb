class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :soccer_field, null: false, foreign_key: true
      t.bigint :current_price
      t.string :booking_used
      t.integer :type_field
      t.date :order_date

      t.timestamps
    end
  end
end
