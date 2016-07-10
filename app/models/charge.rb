class Charge
  include Mongoid::Document

  field :amount, type: BigDecimal
  field :currency, type: String
  field :description, type: String
  field :reference_id, type: String

  belongs_to :card
end
