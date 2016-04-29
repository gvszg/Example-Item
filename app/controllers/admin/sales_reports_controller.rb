class Admin::SalesReportsController < AdminController
  before_action :require_manager

  def item_sales_result
    if %w[month week day].include?(params[:time_field])
    # if params[:time_field] == "month" || params[:time_field] == "week" || params[:time_field] == "day"
      # @item_sales = OrderItem.includes(:item, item: :categories).group(:source_item_id).select(:id, :item_name, :source_item_id, "SUM(item_quantity) as sum_item_quantity").where(created_at: which_time_field_params).order("sum_item_quantity DESC")

      @item_sales = OrderItem.sort_by_item_sales(params[:time_field])
    else
      @item_sales = OrderItem.includes(:item, item: :categories).group(:source_item_id).select(:id, :item_name, :source_item_id, "SUM(item_quantity) as sum_item_quantity").order("sum_item_quantity DESC")
    end

    # if params[:month]
    #   # 30天的資料
    #   @item_sales = OrderItem.includes(:item, item: :categories).group(:source_item_id).select(:id, :item_name, :source_item_id, "SUM(item_quantity) as sum_item_quantity").where(created_at: (Time.now - 30.day)..Time.now).order("sum_item_quantity DESC")
    # elsif params[:week]
    #   # 7天的資料
    #   @item_sales = OrderItem.includes(:item, item: :categories).group(:source_item_id).select(:id, :item_name, :source_item_id, "SUM(item_quantity) as sum_item_quantity").where(created_at: (Time.now - 7.day)..Time.now).order("sum_item_quantity DESC")
    # elsif params[:day]
    #   # 1天的資料
    #   @item_sales = OrderItem.includes(:item, item: :categories).group(:source_item_id).select(:id, :item_name, :source_item_id, "SUM(item_quantity) as sum_item_quantity").where(created_at: (Time.now - 1.day)..Time.now).order("sum_item_quantity DESC")
    # else
    #   @item_sales = OrderItem.includes(:item, item: :categories).group(:source_item_id).select(:id, :item_name, :source_item_id, "SUM(item_quantity) as sum_item_quantity").order("sum_item_quantity DESC")
    # end
  end

  def item_revenue_result
    if %w[month week day].include?(params[:time_field])
      @item_revenue = OrderItem.sort_by_item_revenue(params[:time_field])
    else
      @item_revenue = OrderItem.includes(:item, item: :categories).group(:source_item_id).select(:id, :item_name, :source_item_id, "SUM(item_quantity * item_price) as sum_item_revenue").order("sum_item_revenue DESC")
    end
  end

  # private

  # def intial_item_sales
  #   @item_sales = OrderItem.includes(:item, item: :categories).group(:source_item_id).select(:id, :item_name, :source_item_id, "SUM(item_quantity) as sum_item_quantity").order("sum_item_quantity DESC")
  # end

  # def time_field_for_item_sales
  #   @item_sales = OrderItem.includes(:item, item: :categories).group(:source_item_id).select(:id, :item_name, :source_item_id, "SUM(item_quantity) as sum_item_quantity").where(created_at: which_time_field_params).order("sum_item_quantity DESC")
  # end

  # def which_time_field_params
  #   case params[:time_field]
  #   when "month"
  #     return (Time.now - 30.day)..Time.now
  #   when "week"
  #     return (Time.now - 7.day)..Time.now
  #   when "day"
  #     return (Time.now - 1.day)..Time.now
  #   end
  # end
end