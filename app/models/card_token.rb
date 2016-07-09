class CardToken
  include Mongoid::Document

  field :used, type: Boolean, default: false
  field :expires_at, type: Date, default: -> { 1.day.from_now }
  field :hash, type: String, default: -> { SecureRandom.hex(4) }

  validates :used, :expires_at, :hash, presence: true

  belongs_to :card
end
