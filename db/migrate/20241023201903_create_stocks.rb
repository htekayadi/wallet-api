class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :symbol
      t.decimal :price, precision: 15, scale: 2

      t.timestamps
    end
  end
end
