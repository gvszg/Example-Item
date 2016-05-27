namespace :item_cost do
  task :get_cost => :environment do
    Item.all.each do |item|
      if item.cost.nil?
        # i.cost = (i.price.to_f / 3).round(2)
        item.cost = (item.price.to_f / 3).round(2)
        item.save!
        puts "Cost saved"
      end
    end
  end
end