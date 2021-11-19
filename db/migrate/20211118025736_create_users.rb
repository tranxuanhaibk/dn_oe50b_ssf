class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.integer :role
      t.string :activation_digest
      t.boolean :activated

      t.timestamps
    end
  end
end
