class CardTokenSerializer < ActiveModel::Serializer
  attributes :used, :expires_at, :code
end
