class WalletableEntity < ApplicationRecord
  has_one :wallet, as: :walletable, dependent: :destroy
end