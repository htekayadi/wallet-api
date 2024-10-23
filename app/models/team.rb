class Team < ApplicationRecord
  has_one :wallet, as: :walletable, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_create :create_wallet

  private

  def create_wallet
    Wallet.create(name: "#{self.name}'s Wallet", walletable: self, balance: 0)
  end
end
