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

  def generate_result_order(order, info, items)
    # 訂單資料
    result_order = {}
    result_order[:id] = order.id
    result_order[:uid] = order.uid
    result_order[:user_id] = order.user_id
    result_order[:status] = order.status
    result_order[:items_price] = order.items_price
    result_order[:ship_fee] = order.ship_fee
    result_order[:total] = order.total
  
    # 收件明細
    include_info = {}
    include_info[:id] = info.id
    include_info[:ship_name] = info.ship_name
    include_info[:ship_phone] = info.ship_phone
    include_info[:ship_store_code] = info.ship_store_code
    include_info[:ship_store_id] = info.ship_store_id
    include_info[:ship_store_name] = info.ship_store_name
    result_order[:info] = include_info

    # 商品明細
    include_items = []
    items.each do |item|
      item_hash = {}
      item_hash[:name] = item.item_name
      item_hash[:style] = item.item_style
      item_hash[:quantity] = item.item_quantity
      item_hash[:price] = item.item_price
      include_items << item_hash
    end
    result_order[:items] = include_items

    # 完整資料
    return result_order
  end

  def created_at_for_api
    self.created_at.strftime("%Y-%m-%d")
  end
end