class CardToken
  include Mongoid::Document

  field :used, type: Boolean, default: false
  field :expires_at, type: Date, default: 1.day.from_now
  field :code, type: String

  validates :used, :expires_at, :hash, presence: true

  belongs_to :card
  validates_associated :card

  before_save :create_code

  def is_not_usable
    used == true || expires_at < Date.today
  end

  def invalidate!
    update_attributes(used: true)
  end

  private

  def create_code
    self.code = SecureRandom.hex
  end
end
