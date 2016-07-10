class Api::V1::ChargesController < Api::V1::ApplicationController
  before_action :set_and_validate_token

  def create
    charge = Charge.create(permitted_params) do |charge|
      charge.card = card
    end

    @token.invalidate!

    if charge.save
      render json: charge
    else
      render json: { messages: charge.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:charge).permit(:amount, :currency, :description, :reference_id)
  end

  def set_and_validate_token
    @token = CardToken.find_by(code: params["charge"]["card"])
    render json: { messages: "Token is no longer valid" }, status: :unprocessable_entity if @token.is_not_usable
  end

  def card
    @token && @token.card
  end
end
