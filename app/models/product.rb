class Product < ActiveRecord::Base
  belongs_to :user
  has_many :placements
  has_many :orders, through: :placements

  validates :title, :user_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    presence: true

  def self.filter_by_title(keyword)
    where("lower(title) LIKE :keyword", keyword: "%#{keyword.downcase}%")
  end

  def self.above_or_equal_to_price(price)
    where("price >= :price", price: price)
  end

  def self.below_or_equal_to_price(price)
    where("price <= :price", price: price)
  end

  def self.recent
    order("updated_at")
  end

  def self.search(params = {})
    products = Product.all
    products = products.filter_by_title(params[:keyword]) if params[:keyword]
    products = products.above_or_equal_to_price(params[:min_price].to_f) if params[:min_price]
    products = products.below_or_equal_to_price(params[:max_price].to_f) if params[:max_price]
    products = products.recent(params[:recent]) if params[:recent].present?

    products
  end
end
