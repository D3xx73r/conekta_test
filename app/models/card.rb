class Card
  include Mongoid::Document

  field :cardholder_name, type: String
  field :bin, type: Mongoid::EncryptedString
  field :last_four_digits, type: Mongoid::EncryptedString
  field :exp_month, type: String
  field :exp_year, type: String
  field :schema, type: String
  field :brand, type: String

  validates :exp_year, :exp_month, :bin, presence: true

  validate :expiry_date_not_in_the_past, :luhn_check

  has_one :card_token
  has_one :address
  has_many :charges

  accepts_nested_attributes_for :address

  before_save :set_brand

  def create_token
    card_token || CardToken.create(card: self)
  end

  private

  def expiry_date_not_in_the_past
    date = Date.parse("01/#{exp_month}/#{exp_year}")

    if date && date < Date.today
      errors.add(:expiration_date, "Cannot be in the past")
    end
  end

  def set_brand
    case(bin)
    when /^3[47]\d{13}$/
      self.brand = "AMEX"
    when /^4\d{12}(\d{3})?$/
      self.brand = "VISA"
    when /^5\d{15}|36\d{14}$/
      self.brand = "MC"
    end
  end

  def luhn_check
    digits = ''

    bin.split('').reverse.each_with_index do |digit, index|
      digits += digit if index % 2 == 0
      digits += (digit.to_i * 2).to_s if index % 2 == 1
    end

    if digits.split('').inject(0) { |sum, digit| sum + digit.to_i } % 10 == 0
      true
    else
      errors.add(:bin, "Credit card number is invalid")
    end
  end
end
