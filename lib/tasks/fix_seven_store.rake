namespace :fix_seven_store do
  task :with_null_road_id => :environment do
    empty_road_stores = Store.seven_stores.select { |store| store.road_id.nil? }

    section_list = {
                      "1" => "一",
                      "2" => "二",
                      "3" => "三",
                      "4" => "四",
                      "5" => "五",
                      "6" => "六",
                      "7" => "七",
                      "8" => "八",
                      "9" => "九"
                  }

    empty_road_stores.each do |store|

      address = store.address

      store.town.roads.each do |road|

        road_name = road.name

        chinese_section = road_name[-2].to_s

        numerical_section = section_list.key(road_name[-2]).to_s

        transfer_road_name = road_name.tr(chinese_section, numerical_section).to_s

        if address.include?(transfer_road_name)

          store.road = road

          store.save!

          puts store.road.name if store.road

        end

      end

    end

  end

end