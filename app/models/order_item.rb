# == Schema Information
#
# Table name: order_items
#
#  id            :integer          not null, primary key
#  order_id      :integer
#  item_quantity :integer
#  item_name     :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  item_price    :integer
#  item_style    :string(255)
#

class OrderItem < ActiveRecord::Base
  belongs_to :order
end