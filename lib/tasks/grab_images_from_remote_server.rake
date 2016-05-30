namespace :images do
  require 'net/http'
  include ActiveSupport::Rescuable

  desc "transer images from Server"
  task :photos  => :environment do
    Photo.all.each do |p|
      begin
        unless file_exist?("#{p.image.url}")        
          url = "#{ENV['production_asset_host']}#{p.image.url}"
          p.remove_image
          p.remote_image_url = url
          p.save!
          puts "Photo id: #{p.id} saved!"
        end
      rescue
        next
      end
    end
  end

  task :items  => :environment do
    Item.all.each do |i|
      begin
        unless file_exist?("#{i.cover.url}")
          # binding.pry
          url = "#{ENV['production_asset_host']}#{i.cover.url}"
          i.remove_cover
          i.remote_cover_url = url
          # binding.pry
          i.save!
          puts "Item id: #{i.id} saved!"
        end
      rescue
        next
      end
    end
  end

  task :item_specs  => :environment do
    ItemSpec.all.each do |i|
      begin
        unless file_exist?("public/#{i.style_pic.url}")
          url = "#{ENV['production_asset_host']}#{i.style_pic.url}"
          i.remove_style_pic
          i.remote_style_pic_url = url
          i.save!
          puts "ItemSpec id: #{i.id} saved!"
        end
      rescue
        next
      end
    end
  end

  def file_exist?(url)
    begin
      open(url)
    rescue
      result = false
    else
      result = true
    end
    result
  end
end