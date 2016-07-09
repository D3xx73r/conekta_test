require 'rails_helper'

RSpec.describe Card, type: :model do
  it { is_expected.to respond_to(:cardholder_name) }
  it { is_expected.to respond_to(:bin) }
  it { is_expected.to respond_to(:last_four_digits) }
  it { is_expected.to respond_to(:exp_month) }
  it { is_expected.to respond_to(:exp_year) }
  it { is_expected.to respond_to(:schema) }
  it { is_expected.to respond_to(:brand) }

  it { is_expected.to accept_nested_attributes_for(:address) }

  it { is_expected.to have_one(:card_token) }
  it { is_expected.to have_one(:address) }

  describe "validations" do
    it "adds error to base if expiration date is in the past" do
      card = Card.new(exp_month: "01", exp_year: "2016", bin: "4242424242424242")
      expect(card.valid?).to eq(false)
      expect(card.errors.full_messages).to eq(["Expiration date Cannot be in the past"])
    end

    it "does not add expiration error if date is in the future" do
      card = Card.new(exp_month: "01", exp_year: "2020", bin: "4242424242424242")
      expect(card.valid?).to eq(true)
    end

    it "adds error if card is invalid" do
      card = Card.new(exp_month: "01", exp_year: "2020", bin: "4242424242424")
      expect(card.valid?).to eq(false)
      expect(card.errors.full_messages).to eq(["Bin Credit card number is invalid"])
    end
  end

  describe "callbacks" do
    it "sets the card brand before saving the record" do
      card = Card.create(exp_month: "01", exp_year: "2020", bin: "4242424242424242")
      expect(card.brand).to eq("VISA")
    end
  end

  describe "encrypted_data" do
    it "stores data as encrypted" do
      card = Card.new(bin: "4242424242424242")
      expect(card[:bin]).not_to eq("4242424242424242")
    end

    it "decrypts data when accessing it" do
      card = Card.new(bin: "4242424242424242")
      expect(card.bin).to eq("4242424242424242")
    end
  end

  describe "#create_token" do
    it "returns an associated token" do
      card = Card.new(bin: "4242424242424242")
      token = card.create_token

      expect(token).to be_a(CardToken)
      expect(token.used).to be_falsey
    end
  end
end
