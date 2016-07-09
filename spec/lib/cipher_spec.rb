require "rails_helper"

RSpec.describe Cipher do
  let(:data) { "Some random string" }
  let(:cipher) { Cipher.new('supersecret') }

  describe "#encrypt" do
    it "encripts the passed data" do
      encrypted_data = cipher.encrypt(data)
      expect(encrypted_data).not_to eq(data)
      expect(JSON.parse(encrypted_data)).to be_a(Hash)
    end
  end

  describe "#decrypt" do
    let(:encrypted_data) { cipher.encrypt(data) }

    it "It uses a JSON string to decrypt data" do
      expect(cipher.decrypt(encrypted_data)).to eq(data)
    end
  end
end
