class Product < ApplicationRecord
  include Favoritable

  has_many :orderables
  has_many :carts, through: :orderables


  ORDER_BY = {
    newest: "created_at DESC",
    expensive: "price DESC",
    cheapest: "price ASC"
  }

  has_one_attached :photo

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true



  belongs_to :category
  belongs_to :user, default: -> { Current.user }

  def owner?
    user_id == Current.user&.id
  end
  def broadcast
    broadcast_replace_to self, partial: 'products/product_details', locals: { product: self }
  end
end
