class Product < ActiveRecord::Base
  belongs_to :user

  validates :title, :user_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    presence: true

  def self.filter_by_title(keyword)
    where('lower(title) LIKE :keyword', keyword: "%#{keyword.downcase}%")
  end

  def self.above_or_equal_to_price(price)
    where('price >= :price', price: price)
  end

  def self.below_or_equal_to_price(price)
    where('price <= :price', price: price)
  end

  def self.recent
    order('updated_at')
  end
end
