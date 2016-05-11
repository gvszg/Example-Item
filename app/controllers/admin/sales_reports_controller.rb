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
    @total_sales_income = OrderItem.where(created_at: search_date_params).sum("item_quantity * item_price")

    @total_cost_of_goods = CostStatistic.where(cost_date: search_date_params).sum("cost_of_goods")
    @total_cost_of_freight_in = CostStatistic.where(cost_date: search_date_params).sum("cost_of_freight_in")
    @total_cost_of_advertising = CostStatistic.where(cost_date: search_date_params).sum("cost_of_advertising")

    @total_order_quantity = Order.where(created_at: search_date_params).count
    @total_cost_ship_fee = Order.where(created_at: search_date_params).sum("ship_fee")
    @cancelled_order_quantity = Order.where(created_at: search_date_params, status: 4).count
    @cancelled_order_amount = Order.where(created_at: search_date_params, status: 4).sum("items_price")
    @cancelled_order_ship_fee = Order.where(created_at: search_date_params, status: 4).sum("ship_fee")

    @gross = ((@total_sales_income - @total_cost_of_goods - @total_cost_of_freight_in - @total_cost_ship_fee) / @total_order_quantity) - (@total_cost_of_advertising / @total_order_quantity)
    @surplus = @gross - @cancelled_order_amount - @cancelled_order_ship_fee
  end

  private

  def time_until_range
    TimeSupport.time_until(params[:time_field])
  end

  def cost_statistic_params
    params.require(:cost_statistic).permit(:cost_of_goods, :cost_of_advertising, :cost_of_freight_in, :cost_date)
  end

  def search_date_params
    params[:start_cost_date].to_date..params[:end_cost_date].to_date
  end
end