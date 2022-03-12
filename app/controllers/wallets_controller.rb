class WalletsController < ApplicationController
  before_action :authorize_request
  before_action :set_wallet

  # GET /wallets/1
  def show
    render json: @wallet
  end

  # PATCH/PUT /wallets/1
  def update
    if @wallet.update(wallet_params)
      render json: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:balance)
    end

    def set_wallet
      @wallet = @current_user.wallet
    end
end
