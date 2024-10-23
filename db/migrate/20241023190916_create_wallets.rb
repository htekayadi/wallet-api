class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.string :name
      t.decimal :balance, precision: 15, scale: 2
      t.references :walletable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
