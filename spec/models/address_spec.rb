require 'rails_helper'

RSpec.describe Address, type: :model do
  it { is_expected.to respond_to(:street_1) }
  it { is_expected.to respond_to(:street_2) }
  it { is_expected.to respond_to(:city) }
  it { is_expected.to respond_to(:state) }
  it { is_expected.to respond_to(:zip_code) }
  it { is_expected.to respond_to(:country) }

  it { is_expected.to belong_to(:card) }
end
