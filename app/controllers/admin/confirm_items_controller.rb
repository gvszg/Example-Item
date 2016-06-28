class Admin::ConfirmItemsController < AdminController
  before_action :require_manager

  def index
    params[:status] ||= AdminCart::STATUS[:shipping]
    # @confirm_receipts = AdminCart.includes(:taobao_supplier, admin_cart_items: [:item, :item_spec]).where(status: AdminCart::STATUS[:shipping])
    @confirm_receipts = AdminCart.includes(:taobao_supplier, admin_cart_items: [:item, :item_spec]).where(status: params[:status])
  end
end