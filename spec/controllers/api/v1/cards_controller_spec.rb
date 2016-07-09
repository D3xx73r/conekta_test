require 'rails_helper'

RSpec.describe Api::V1::CardsController, type: :controller do
  let(:card) { Card.new(card_only_params) }

  describe "#create" do
    it "stores a card and returns a token" do
      expect(Card).to receive(:new).with(card_only_params).and_return(card)
      post :create, params

      expect(response).to be_success
    end

    it "renders errors if data is invalid" do
      modified_params = params
      modified_params["card"].update("exp_year" => "2000")

      post :create, modified_params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)["messages"]).to eq(["Expiration date Cannot be in the past"])
    end
  end

  private

  def params
    {
      "card" => {
        "cardholder_name" => "Peter Parker",
        "bin" => "4242424242424242",
        "exp_month" => "01",
        "exp_year" => "2018",
        "adress" => {
          "street_1" => "Sample street",
          "street_2" => "Sample street",
          "city" => "Mexicali",
          "state" => "Baja California",
          "zip_code" => "212121",
          "country" => "Mexico"
        }
      }
    }
  end

  def card_only_params
    params["card"].slice("cardholder_name", "bin", "exp_month", "exp_year")
  end
end
