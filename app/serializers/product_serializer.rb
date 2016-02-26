class ProductSerializer < ActiveModel::Serializer
  attributes :title, :price, :published
  belongs_to :user
end
