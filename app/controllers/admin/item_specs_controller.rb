class Admin::ItemSpecsController < AdminController
  before_action :find_item

  def index
    @item_specs = @item.specs
  end

  def new
    @item_spec = @item.specs.new
  end

  def create
    @item_spec = @item.specs.new(spec_params)

    if @item_spec.save!
      flash[:notice] = "成功新增樣式"
      redirect_to admin_item_item_specs_path(@item)
    else
      flash[:alert] = "請確認所有欄位資料是否正確"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_item
    @item = Item.find(params[:item_id])
  end

  def spec_params
    params.require(:item_spec).permit(:style, :style_pic, :style_amount)
  end
end