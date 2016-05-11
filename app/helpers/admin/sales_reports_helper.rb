module Admin::SalesReportsHelper
  def all_time_tab_active(time_param)
    time_param.nil? ? "active" : ""
  end

  def option_time_tab_active(time_param, time_option)
    css_class = ""

    if time_param.present? && request.original_url.include?("time_field=" + time_option)
      css_class = "active"
    end

    return css_class
  end

  def display_date(time)
    time.strftime("%Y-%m-%d")
  end

  def gross_profit(sales_income, cost_of_goods, cost_of_freight_in, cost_ship_fee)
    sales_income - cost_of_goods - cost_of_freight_in - cost_ship_fee
  end
end