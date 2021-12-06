class AddCodeToSoccerFields < ActiveRecord::Migration[6.1]
  def change
    add_column :soccer_fields, :code, :string
  end
end
