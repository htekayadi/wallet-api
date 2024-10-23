class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :source_transactions, class_name: 'Transaction', foreign_key: :source_wallet_id
  has_many :target_transactions, class_name: 'Transaction', foreign_key: :target_wallet_id

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def calculate_balance
    self.balance = source_transactions.sum(:amount) - target_transactions.sum(:amount)
    save!
  end

  def deposit(amount)
    raise ArgumentError, "Amount must be greater than 0" if amount <= 0

    ActiveRecord::Base.transaction do
      self.balance += amount
      save!
    end
  end

  def withdraw(amount)
    raise ArgumentError, "Amount must be greater than 0" if amount <= 0
    raise ArgumentError, "Insufficient funds" if balance < amount

    ActiveRecord::Base.transaction do
      self.balance -= amount
      save!
    end
  end
end