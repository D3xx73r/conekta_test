require 'rails_helper'

RSpec.describe Charge, type: :model do
  it { is_expected.to respond_to(:amount) }
  it { is_expected.to respond_to(:currency) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:reference_id) }

  it { is_expected.to belong_to(:card) }
end
