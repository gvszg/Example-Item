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
      @total_sales_income = OrderItem.created_at_within(search_date_params).total_sales_income
      
      @total_cost_of_goods = @total_cost.total_cost_of_goods
      @total_cost_of_freight_in = @total_cost.total_cost_of_freight_in
      @total_cost_of_advertising = @total_cost.total_cost_of_advertising
      
      @total_order_quantity = @total_order.total_order_quantity
      @total_cost_ship_fee = @total_order.total_cost_ship_fee
      
      @cancelled_order_quantity = @cancelled_order.cancelled_order_quantity
      @cancelled_order_amount = @cancelled_order.cancelled_order_amount
      @cancelled_order_ship_fee = @cancelled_order.cancelled_order_ship_fee
      
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

  def find_order_and_cost_data
    @total_cost = CostStatistic.cost_date_within(search_date_params).select("SUM(cost_of_goods) AS total_cost_of_goods", "SUM(cost_of_freight_in) AS total_cost_of_freight_in", "SUM(cost_of_advertising) AS total_cost_of_advertising")[0]
    @total_order = Order.created_at_within(search_date_params).select("COUNT(*) AS total_order_quantity", "SUM(ship_fee) AS total_cost_ship_fee")[0]
    @cancelled_order = Order.cancelled_at_within(search_date_params).select("COUNT(*) AS cancelled_order_quantity", "SUM(items_price) AS cancelled_order_amount", "SUM(ship_fee) AS cancelled_order_ship_fee")[0]
  end

  def search_date_params
    params[:start_cost_date].to_date..params[:end_cost_date].to_date if params[:start_cost_date] && params[:end_cost_date]
  end
end