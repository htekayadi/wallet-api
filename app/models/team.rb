class Team < WalletableEntity
  after_create :create_wallet

  private

  def create_wallet
    Wallet.create(walletable: self, balance: 0)
  end
end