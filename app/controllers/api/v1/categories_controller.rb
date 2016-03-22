class Api::V1::CategoriesController < ApiController
  # TODO 整理至model
  def index
    # TODO 分批撈資料
    categories = Category.includes(:item_categories, items: [:photos]).all

    # categories = Category.includes(:item_categories, :items).all
    
    render json: categories, only: [:id, :name]
  end

  def show
    # category = Category.includes(:item_categories, :items).find(params[:id])

    # 先將商品與相關圖片讀取好
    category = Category.includes(items: [:photos]).find(params[:id])

    category_name = category.name
    result_category = {}
    include_items = []

    # 減少query數
    items = category.items.where("status = ?", "0")
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