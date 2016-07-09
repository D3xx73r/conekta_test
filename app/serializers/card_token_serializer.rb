class CardTokenSerializer < ActiveModel::Serializer
  attributes :id, :used, :expires_at

  def id
    object.hash.to_s
  end
end
