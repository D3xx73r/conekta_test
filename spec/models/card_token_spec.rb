require 'rails_helper'

RSpec.describe CardToken, type: :model do
  it { is_expected.to respond_to(:used) }
  it { is_expected.to belong_to(:card)}
end
