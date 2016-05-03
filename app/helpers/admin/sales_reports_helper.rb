module Admin::SalesReportsHelper
  def all_time_tab_active(time_param)
    time_param.nil? ? "active" : ""
  end

  # def month_tab_active(time_param)
  #   time_param == "month" ? "active" : ""
  # end

  # def week_tab_active(time_param)
  #   time_param == "week" ? "active" : ""
  # end

  # def day_tab_active(time_param)
  #   time_param == "day" ? "active" : ""
  # end

  def time_tab_active(time_param, time_option)
    css_class = ""

    if time_param.present? && request.original_url.include?("time_field=" + time_option)
      css_class = "active"
    end

    return css_class
  end
end