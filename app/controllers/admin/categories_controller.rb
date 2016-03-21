class Admin::CategoriesController < AdminController
  layout "admin"
  before_action :find_category, only: [:show]

  def index
    @categories = Category.includes(:items, :item_categories).recent

    # respond_to do |format|
    #   format.html
    #   format.json { render :json => @categories }
    # end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "新增分類成功"
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "請確認欄位資料"
      render :new
    end
  end

  def show

    # TODO 
    # 移去用戶API
    result_arr = []    
    items = @category.items
    items.each do |item|
      item_hash = {}
      item_hash[:id] = item.id
      item_hash[:name] = item.name
      item_hash[:price] = item.price
      item_hash[:photo] = item.photos.first.image.url
      result_arr << item_hash                    
    end

    respond_to do |format|
      format.html
      format.json { render :json => result_arr }
    end

  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end