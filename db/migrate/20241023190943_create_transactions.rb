class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.decimal :amount, precision: 15, scale: 2
      t.bigint :source_wallet_id
      t.bigint :target_wallet_id

      t.timestamps
    end
  end
end
