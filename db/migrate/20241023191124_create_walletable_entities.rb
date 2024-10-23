class CreateWalletableEntities < ActiveRecord::Migration[7.2]
  def change
    create_table :walletable_entities do |t|
      t.string :type

      t.timestamps
    end
  end
end
