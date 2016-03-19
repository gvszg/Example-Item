class Order < ActiveRecord::Base
  scope :recent, -> { order(id: :DESC) }

  acts_as_paranoid

  enum status: { order_placed: 0, item_shipping: 1, item_shipped: 2, order_cancelled: 3 }

  belongs_to :user
  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy

  def info_store_code
    info.ship_store_code
  end

  def info_store_name(store_code)
    Store.find_by(store_code: store_code).name
  end

  def info_store_address(store_code)
    Store.find_by(store_code: store_code).address
  end

  def info_user_name
    user.user_name
  end
end