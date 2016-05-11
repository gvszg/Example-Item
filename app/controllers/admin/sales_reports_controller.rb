class Admin::SalesReportsController < AdminController
  before_action :require_manager
  before_action :find_order_and_cost_data, only: [:sales_income_result]

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
    if params[:start_cost_date] && params[:end_cost_date]
      # b. 總銷售金額
      @total_sales_income = OrderItem.created_at_within(search_date_params).total_sales_income
      # c. 總貨物成本
      @total_cost_of_goods = @total_cost.total_cost_of_goods
      # d. 總進貨物流費
      @total_cost_of_freight_in = @total_cost.total_cost_of_freight_in
      # h. 總廣告費用
      @total_cost_of_advertising = @total_cost.total_cost_of_advertising
      # a. 總訂單數
      @total_order_quantity = @total_order.total_order_quantity
      # e. 總出貨物流費
      @total_cost_ship_fee = @total_order.total_cost_ship_fee
      
      # k. 取消訂單數
      @cancelled_order_quantity = @cancelled_order.cancelled_order_quantity
      # l. 取消訂單總金額
      @cancelled_order_amount = @cancelled_order.cancelled_order_amount
      # m. 取消訂單總物流費用
      @cancelled_order_ship_fee = @cancelled_order.cancelled_order_ship_fee
      # f. 毛利(b - c - d - e)
      @gross_profit = (@total_sales_income - @total_cost_of_goods - @total_cost_of_freight_in - @total_cost_ship_fee)
      # g. 平均訂單毛利(f / a)
      @gross_profit_per_order = @gross_profit / @total_order_quantity
      # i. 平均廣告費用(h / a)
      @average_cost_of_advertising = @total_cost_of_advertising / @total_order_quantity
      # j. 平均扣廣告訂單毛利(g - i)
      @average_gross_profit_except_ads = @gross_profit_per_order - @average_cost_of_advertising
      # n. 實際毛利(f - l)
      @actual_gross_profit = @gross_profit - @cancelled_order_amount
      # o. 實際平均訂單毛利(f - l / a - k)
      @actual_average_gross_profit = @actual_gross_profit / (@total_order_quantity - @cancelled_order_quantity)
    end
  end

  private

  def time_until_range
    TimeSupport.time_until(params[:time_field])
  end

  def cost_statistic_params
    params.require(:cost_statistic).permit(:cost_of_goods, :cost_of_advertising, :cost_of_freight_in, :cost_date)
  end

  def find_order_and_cost_data
    @total_cost = CostStatistic.cost_date_within(search_date_params).select("SUM(cost_of_goods) AS total_cost_of_goods", "SUM(cost_of_freight_in) AS total_cost_of_freight_in", "SUM(cost_of_advertising) AS total_cost_of_advertising")[0]
    @total_order = Order.created_at_within(search_date_params).select("COUNT(*) AS total_order_quantity", "SUM(ship_fee) AS total_cost_ship_fee")[0]
    @cancelled_order = Order.cancelled_at_within(search_date_params).select("COUNT(*) AS cancelled_order_quantity", "SUM(items_price) AS cancelled_order_amount", "SUM(ship_fee) AS cancelled_order_ship_fee")[0]
  end

  def search_date_params
    params[:start_cost_date].to_date..params[:end_cost_date].to_date if params[:start_cost_date] && params[:end_cost_date]
  end
end