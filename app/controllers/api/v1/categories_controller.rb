class Api::V1::CategoriesController < ApiController
  # TODO 整理至model
  def index
    # TODO 分批撈資料
    categories = Category.includes(:items, :item_categories).all
    
    render json: categories, only: [:id, :name]
  end

  def show
    category = Category.find(params[:id])
    category_name = category.name
    result_category = {}
    include_items = []
    items = category.items    
    items.each do |item|
      item_hash = {}
      item_hash[:id] = item.id
      item_hash[:name] = item.name
      item_hash[:price] = item.price
      item_hash[:cover] = item.default_photo
      include_items << item_hash
    end
    result_category[category_name] = include_items    
    render json: result_category
  end
end