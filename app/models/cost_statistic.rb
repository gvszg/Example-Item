class CostStatistic < ActiveRecord::Base
  scope :recent, -> { order(id: :DESC) }
  scope :cost_date_within, -> (time_param) { where(cost_date: time_param) }
  # scope :total_cost_of_goods, -> { sum("cost_of_goods") }
  # scope :total_cost_of_freight_in, -> { sum("cost_of_freight_in") }
  # scope :total_cost_of_advertising, -> { sum("cost_of_advertising") }

  validates_presence_of :cost_of_goods, :cost_of_advertising, :cost_of_freight_in
  validates_numericality_of :cost_of_goods, :cost_of_advertising, :cost_of_freight_in, only_integer: true
end