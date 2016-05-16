class Admin::TaobaoSuppliersController < AdminController
  before_action :require_manager

  def index
    @taobao_suppliers = TaobaoSupplier.all.paginate(page: params[:page])
  end

  def new
    @taobao_supplier = TaobaoSupplier.new
  end

  def create
    @taobao_supplier = TaobaoSupplier.new(taobao_supplier_params)

    if @taobao_supplier.save!
      flash[:notice] = "成功新增淘寶商家"
      redirect_to admin_taobao_suppliers_path
    else
      flash[:danger] = "請檢察輸入的資料是否正確 "
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

  def taobao_supplier_params
    params.require(:taobao_supplier).permit(:name, :link)
  end
end