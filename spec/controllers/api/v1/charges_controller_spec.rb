require 'rails_helper'

RSpec.describe Api::V1::ChargesController, type: :controller do
  let(:card) { Card.create(exp_month: "01", exp_year: "2020", bin: "4242424242424242") }
  let(:valid_token) { CardToken.create(card: card) }

  describe "#create" do
    before do
      allow(CardToken).to receive(:find_by).and_return(valid_token)
    end

    it "creates a charge using the passed in token" do
      post :create, params

      expect(response).to be_success
      expect(JSON.parse(response.body).slice(*expected_params)).to eq(params["charge"].slice(*expected_params))
    end
  end

  private

  def expected_params
    %w(amount description)
  end

  def params
    {
      "charge" => {
        "amount" => "5000.0",
        "currency" => "MXN",
        "description" => "Some test description",
        "reference_id" => "65465",
        "card" => valid_token.hash
      }
    }
  end
end
