require 'rails_helper'

RSpec.describe CardToken, type: :model do
  it { is_expected.to respond_to(:used) }
  it { is_expected.to respond_to(:expires_at) }
  it { is_expected.to respond_to(:code) }

  it { is_expected.to belong_to(:card) }

  it { is_expected.to validate_associated(:card) }

  let(:card) { Card.create(exp_month: "01", exp_year: "2020", bin: "4242424242424242") }
  let(:valid_token) { CardToken.create(card: card) }

  describe "#is_not_usable" do
    it "returns false if the token is usable" do
      expect(valid_token.is_not_usable).to eq(false)
    end

    it "returns true if token is not usable" do
      allow(valid_token).to receive(:used).and_return(true)
      allow(valid_token).to receive(:expires_at).and_return(Date.yesterday)

      expect(valid_token.is_not_usable).to eq(true)
    end
  end
end
