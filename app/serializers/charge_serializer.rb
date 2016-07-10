class ChargeSerializer < ActiveModel::Serializer
  attributes :id, :amount, :currency, :description, :reference_id, :state
  STATES = %w(failed pending charged).freeze

  def state
    STATES.sample
  end
end
