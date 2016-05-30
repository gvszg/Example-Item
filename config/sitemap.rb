require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'https://www.mmwooo.com/'
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 0.9
  Category.find_each do |category|
    add category_path(category),  :changefreq => 'daily', :priority => 0.9
  end
  Item.find_each do |item|
    item.categories.each do |category|
      add category_item_path(category, item),  :changefreq => 'daily', :priority => 0.9
    end
  end
end
SitemapGenerator::Sitemap.ping_search_engines