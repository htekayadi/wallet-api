class TransactionsController < ApplicationController

  def index
    wallet_id = @current_user.wallet.id
    @transactions = Transaction.for_wallet(wallet_id)

    formatted_transactions = @transactions.map do |transaction|
      {
        transaction_type: transaction.transaction_type,
        amount: transaction.amount.to_s,
        transaction_time: transaction.created_at.iso8601
      }
    end

    render json: formatted_transactions
  end
end