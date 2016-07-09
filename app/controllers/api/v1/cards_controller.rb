class Api::V1::CardsController < ApplicationController
  def create
    card = Card.new(permitted_params)

    if card.save
      token = card.create_token
      render json: token
    else
      render json: { messages: card.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:card).permit(
      :cardholder_name,
      :bin,
      :exp_month,
      :exp_year,
      address: [:street_1, :street_2, :city, :state, :zip_code, :country]
    )
  end
end
