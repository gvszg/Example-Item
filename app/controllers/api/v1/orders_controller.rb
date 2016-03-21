class Api::V1::OrdersController < ApiController
  # TODO 重構整理
  def create
    begin
      # 訂單 Order
      order = Order.new
      order.uid = params[:uid]
      order.user_id = User.find_by(uid: params[:uid]).id
      order.items_price = params[:items_price]
      order.ship_fee = params[:ship_fee]
      order.total = params[:total]
      order.save!

      # 收件資訊 OrderInfo
      info = OrderInfo.new
      info.order_id = order.id
      info.ship_name = params[:ship_name]
      info.ship_phone = params[:ship_phone]
      info.ship_store_code = params[:ship_store_code]
      info.ship_store_id = params[:ship_store_id]
      info.save!

      # 商品明細 OrderItem
      params[:products].each do |product|
        item = OrderItem.new
        item.order_id = order.id
        item.item_name = product[:name]
        item.item_quantity = product[:quantity]
        item.item_price = product[:price]
        item.save!
      end

      render json: "success"
    rescue Exception => e
      render json: "error"
    end
  end

  def index
    orders = Order.includes(:user, :info, :items).all
    render json: orders, only: [:id, :user_id, :total, :status, :uid]
  end

  def show
    order = Order.includes(:user, :info, :items).find(params[:id])
    info = order.info
    items = order.items
    result_order = order.generate_result_order(order, info, items)
    render json: result_order
  end
end