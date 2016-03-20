class Admin::PhotosController < AdminController
  before_action :find_item
  before_action :find_photo, only: [:edit, :update, :destroy]

  def index
    @photos = @item.photos
  end

  def new
    @photo = @item.photos.new
  end

  def create
    @photo = @item.photos.new(photo_params)

    if @photo.save!
      flash[:notice] = "新增圖片成功"
      redirect_to admin_item_photos_path(@item)
    else
      flash.now[:alert] = "請確認上傳圖片是否正確"
      render :edit
    end
  end

  def edit    
  end

  def update
    if @photo.update!(photo_params)
      flash[:notice] = "編輯完成"
      redirect_to admin_item_photos_path(@item)
    else
      flash.now[:alert] = "請確認編輯內容是否正確"
      render :edit
    end
  end

  def destroy
    @photo.destroy!
    flash[:warning] = "圖片已刪除"
    redirect_to :back
  end

  private

  def find_item
    @item = Item.find(params[:item_id])
  end

  def find_photo
    @photo = @item.photos.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:image, :photo_intro)
  end
end