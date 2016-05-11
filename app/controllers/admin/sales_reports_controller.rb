class Admin::SalesReportsController < AdminController
  before_action :require_manager

  def item_sales_result
    if %w[month week day].include?(params[:time_field])
      @item_sales = OrderItem.created_at_within(time_until_range).sort_by_sales
    else
      @item_sales = OrderItem.sort_by_sales
    end
  end

  def item_revenue_result
    if %w[month week day].include?(params[:time_field])
      @item_revenue = OrderItem.created_at_within(time_until_range).sort_by_revenue
    else
      @item_revenue = OrderItem.sort_by_revenue
    end
  end

  def cost_statistics_index
    @cost_statistics = CostStatistic.recent
  end

  def cost_statistics_create
    @cost_statistic = CostStatistic.create!(cost_statistic_params)
    redirect_to cost_statistics_index_admin_sales_reports_path
  end

  def sales_income_result
    # if params[:start_cost_date] && params[:end_cost_date]
    if search_date_params
      @total_sales_income = OrderItem.created_at_within(search_date_params).total_sales_income

      @total_cost = CostStatistic.cost_date_within(search_date_params).select("SUM(cost_of_goods) AS total_cost_of_goods", "SUM(cost_of_freight_in) AS total_cost_of_freight_in", "SUM(cost_of_advertising) AS total_cost_of_advertising")[0].serializable_hash
      @total_cost_of_goods = @total_cost["total_cost_of_goods"]
      @total_cost_of_freight_in = @total_cost["total_cost_of_freight_in"]
      @total_cost_of_advertising = @total_cost["total_cost_of_advertising"]
      # @total_cost_of_goods = CostStatistic.cost_date_within(search_date_params).total_cost_of_goods
      # @total_cost_of_freight_in = CostStatistic.cost_date_within(search_date_params).total_cost_of_freight_in
      # @total_cost_of_advertising = CostStatistic.cost_date_within(search_date_params).total_cost_of_advertising


      @total_order = Order.created_at_within(search_date_params).select("COUNT(*) AS total_order_quantity", "SUM(ship_fee) AS total_cost_ship_fee")[0].serializable_hash
      @total_order_quantity = @total_order["total_order_quantity"]
      @total_cost_ship_fee = @total_order["total_cost_ship_fee"]
      # @total_order_quantity = Order.where(created_at: search_date_params).count
      # @total_order_quantity = Order.where(created_at: search_date_params).sum("ship_fee")


      @cancelled_order = Order.cancelled_at_within(search_date_params).select("COUNT(*) AS cancelled_order_quantity", "SUM(items_price) AS cancelled_order_amount", "SUM(ship_fee) AS cancelled_order_ship_fee")[0].serializable_hash
      @cancelled_order_quantity = @cancelled_order["cancelled_order_quantity"]
      @cancelled_order_amount = @cancelled_order["cancelled_order_amount"]
      @cancelled_order_ship_fee = @cancelled_order["cancelled_order_ship_fee"]
      # @cancelled_order_quantity = Order.where(created_at: search_date_params, status: 4).count
      # @cancelled_order_amount = Order.where(created_at: search_date_params, status: 4).sum("items_price")
      # @cancelled_order_ship_fee = Order.where(created_at: search_date_params, status: 4).sum("ship_fee")

      @gross = ((@total_sales_income - @total_cost_of_goods - @total_cost_of_freight_in - @total_cost_ship_fee) / @total_order_quantity) - (@total_cost_of_advertising / @total_order_quantity)
      @surplus = @gross - @cancelled_order_amount
    end
  end

  private

  def time_until_range
    TimeSupport.time_until(params[:time_field])
  end

  def cost_statistic_params
    params.require(:cost_statistic).permit(:cost_of_goods, :cost_of_advertising, :cost_of_freight_in, :cost_date)
  end

  def search_date_params
    params[:start_cost_date].to_date..params[:end_cost_date].to_date if params[:start_cost_date] && params[:end_cost_date]
  end
end