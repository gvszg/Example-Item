# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

order = Order.create(user_id: 1, total: 560, uid: 74328, ship_fee: 60, items_price: 500)

OrderInfo.create(order_id: order.id, ship_name: "矇矇萌", ship_address: "這裏不是強國", ship_store_code: 54482, ship_phone: "02-23256420", ship_store_id: 5, ship_store_name: "全家通昌店")

OrderItem.create(order_id: order.id, item_quantity: 5, item_name: "你不是真正的快樂", item_price: 100, item_style: "A~HA")