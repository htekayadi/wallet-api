class WalletsController < ApplicationController
  before_action :set_wallet, only: [:user_wallet, :deposit, :withdraw, :transfer]

  # Get wallet for current user
  def user_wallet
    render json: wallet_response_format(@wallet)
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Wallet not found' }, status: :not_found
  end

  # Get wallet for team
  def team_wallet
    team_wallet = Team.includes(:wallet).find(params[:team_id]).wallet
    render json: wallet_response_format(team_wallet)
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Team not found' }, status: :not_found
  end

  # Get wallet for stock
  def stock_wallet
    stock_wallet = Stock.includes(:wallet).find(params[:stock_id]).wallet
    render json: wallet_response_format(stock_wallet)
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Stock not found' }, status: :not_found
  end

  # Deposit money into a wallet
  def deposit
    amount = params[:amount].to_d
    if amount.positive?
      @wallet.balance += amount
      if @wallet.save
        render json: wallet_response_format(@wallet), status: :ok
      else
        render json: { error: @wallet.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Deposit amount must be positive' }, status: :unprocessable_entity
    end
  end

  # Withdraw money from a wallet
  def withdraw
    amount = params[:amount].to_d
    if amount.positive? && @wallet.balance >= amount
      @wallet.balance -= amount
      if @wallet.save
        render json: wallet_response_format(@wallet), status: :ok
      else
        render json: { error: @wallet.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Insufficient balance or invalid amount' }, status: :unprocessable_entity
    end
  end

  # Transfer money between wallets
  def transfer
    target_wallet = Wallet.find(params[:target_wallet_id])
    amount = params[:amount].to_d


    if amount.positive? && @wallet.balance >= amount
      ActiveRecord::Base.transaction do
        @wallet.withdraw(amount)
        target_wallet.deposit(amount)
        
        # Create debit transaction for the source wallet
        Transaction.create!(transaction_type: 'debit', amount: amount, source_wallet: @wallet)

        # Create credit transaction for the target wallet
        Transaction.create!(transaction_type: 'credit', amount: amount, target_wallet: target_wallet)
      end

      render json: { message: 'Transfer successful', source_wallet: wallet_response_format(@wallet), target_wallet: wallet_response_format(target_wallet) }, status: :ok
    else
      render json: { error: 'Insufficient balance or invalid amount' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Target wallet not found' }, status: :not_found
  rescue ActiveRecord::ActiveRecordError
    render json: { error: 'Transfer failed' }, status: :unprocessable_entity
  end

  private

  def set_wallet
    @wallet = @current_user.wallet
  end

  def wallet_response_format(wallet)
    {
      id: wallet.id,
      name: wallet.name,
      balance: wallet.balance.to_s # Ensure balance is returned as a string
    }
  end
end