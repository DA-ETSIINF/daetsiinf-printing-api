class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate_with_token!, only: :create
  before_action :admin_user, only: :create

  def create
    admin_id = current_user.id
    email = params[:transaction][:email]
    user = User.find_by(email: email)
    user_id = user.id
    transaction = Transaction.new(admin_id: admin_id, user_id: user_id,
      amount: params[:transaction][:amount])
      if params[:transaction][:amount].to_f <= 0
        render json: { errors: "Error saving transaction" }, status: 422
      elsif transaction.save
        total = user.balance + transaction.amount
        if user.update(balance: total)
          render json: user.balance, status: 200, location: [:api, user]
        else
          render json: { errors: "Error updating balance" }, status: 422
        end
      else
        render json: { errors: "Error saving transaction" }, status: 422
      end
  end
end
