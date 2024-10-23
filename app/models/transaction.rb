class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validates :transaction_type, inclusion: { in: %w[credit debit] }

  validate :valid_wallets

  scope :for_wallet, ->(wallet_id) {
    where('source_wallet_id = ? OR target_wallet_id = ?', wallet_id, wallet_id)
  }

  private

  def valid_wallets
    if transaction_type == 'credit' && !source_wallet.nil?
      errors.add(:source_wallet, 'must be nil for credits')
    elsif transaction_type == 'debit' && !target_wallet.nil?
      errors.add(:target_wallet, 'must be nil for debits')
    end
  end
end