class Admin::OrdersController < AdminController
  before_action :find_order, only: [:show, :item_shipping, :item_shipped, :order_cancelled]

  def index
    @orders = Order.includes(:user, :info, :items).recent

    respond_to do |format|
      format.html
      format.json { render json: @orders, only: [:id, :user_id, :uid, :total, :is_paid, :status, :payment_method, :ship_fee, :items_price] }
    end
  end

  def show
    
    @info = @order.info
    @items = @order.items

    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def item_shipping
    begin
      @order.update_attributes!(status: 1)
      flash[:notice] = "已將編號：#{@order.id} 訂單狀態設為已出貨"
    rescue ActiveRecord::ActiveRecordError
      flash[:alert] = "請仔細確認訂單的實際處理進度"
    end

    redirect_to :back
  end

  def item_shipped
    begin
      @order.update_attributes!(status: 2)
      flash[:notice] = "已將編號：#{@order.id} 訂單狀態設為完成取貨"
    rescue ActiveRecord::ActiveRecordError
      flash[:alert] = "請仔細確認訂單的實際處理進度"
    end

    redirect_to :back
  end

  def order_cancelled
    begin
      @order.update_attributes!(status: 3)
      flash[:alert] = "已將編號：#{@order.id} 訂單狀態設為訂單取消"
    rescue ActiveRecord::ActiveRecordError
      flash[:alert] = "請仔細確認訂單的實際處理進度"
    end

    redirect_to :back
  end

  private

  def find_order
    @order = Order.includes(:user, :info, :items).find(params[:id])
  end
end