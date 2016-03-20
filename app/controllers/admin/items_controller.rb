class Admin::ItemsController < AdminController
  before_action :find_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:photos, :item_categories, :categories).recent

    respond_to do |format|
      format.html
      format.json { render :json => @items }
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:notice] = "新增商品成功"
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "請確認欄位資料"
      render :new
    end
  end

  def show
    item_arr = Array.new
    item_arr << @item
    item_arr << @photos

    respond_to do |format|
      format.html
      format.json { render :json =>  item_arr, except: [ :slug, :status, :deleted_at, :created_at, :updated_at ] }
    end
  end

  def edit    
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "成功更新商品"
      redirect_to admin_item_path(@item)
    else
      flash.now[:alert] = "請確認欄位名稱"
      render :edit
    end
  end

  def destroy
    @item.destroy
    flash[:warning] = "商品已刪除"
    redirect_to admin_root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :image, :slug, :description, category_ids: [])
  end

  def find_item
    @item = Item.includes(:photos).find(params[:id])
    @photos = @item.photos
  end
end