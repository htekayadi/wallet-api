class User < ApplicationRecord
  has_secure_password
  
  before_create :generate_token

 	has_one :wallet, as: :walletable, dependent: :destroy
  
  after_create :create_wallet

  def generate_token
    self.token = SecureRandom.hex(20)
  end

  def reset_token!
    self.token = SecureRandom.hex(20)
    save!
  end

  def create_wallet
    Wallet.create(name: "#{self.name}'s Wallet", balance: 0, walletable: self)
  end
end
