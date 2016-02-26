class ProductSerializer < ActiveModel::Serializer
  attributes *Product.column_names
end
