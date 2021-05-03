class Api::V1::AccountsController < ApplicationController
  # before_action :check_owner, only: [:withdraw]
  before_action :set_account, only: [:show]
  before_action :authenticate_user, only: [:create, :show,:deposit, :withdraw, :transfer]


  def create
    account = current_user.account.build(account_params)
    if account.save
      render json: AccountSerializer.new(account).serializable_hash.to_json, status: :created
    else
      render json: {errors: account.errors}, status: :unprocessable_entity
    end
  end


  def deposit
    account_params = params.permit(:account_nr)
    account = Account.find_by_account_nr(account_params[:account_nr])
    return head :not_found unless account
    return head :unprocessable_entity unless Account.deposit(account, amount)
    Transaction.create(amount: amount,tran_type: "DEPOSIT", account_id: account.id)
    render json: {message: "deposited"}, status: :ok
  end

  def withdraw
    owner_params = params.require(:account).permit(:user_id)
    @owner_id = User.find_by_id(owner_params[:user_id])
    account_params = params.require(:account).permit(:account_nr)
    account = Account.find_by_account_nr(account_params[:account_nr])
    return head :not_found unless account
    return head :unprocessable_entity unless Account.withdraw(account, amount)
    Transaction.create(amount: amount,tran_type: "WITHDRAWAl", account_id: account.id)
    render json: {message: "withdrawn"}, status: :ok
  end

  def transfer
    account_params = params.permit(:from_account)
    account = Account.find_by_account_nr(account_params[:from_account])
    return head :not_found unless account
    recipient_param = params.permit(:to_account)
    recipient = Account.find_by_account_nr(recipient_param[:to_account])
    return head :not_found unless recipient
    return head :unprocessable_entity unless Account.transfer(account, recipient, amount)
    Transaction.create(amount: amount,tran_type: "TRANSFER", account_id: account.id)
    render json: {message: "transferred"}
  end

  def show
    render json: AccountSerializer.new(@account).serializable_hash, status: :ok
  end



  private
  def set_account
    @account = Account.find(params[:id])
  end
  
  def account_params
    params.require(:account).permit(:balance)
  end

  # def check_owner
  #   render json: {message: "Not Authorized"}, status: :forbidden unless @account.id ==  current_user&.id
  # end
  def amount
    param = params.permit(:amount)
    param[:amount]
  end

end
