class Product < ApplicationRecord
	has_many :order_items
  validates :title, :description, :price, presence: true
end
