class Admin::NotificationsController < AdminController
  before_action :require_manager
  before_action :find_notification, only: [:show]

  def index
    @notification_page = @notifications = Notification.includes(:item).recent.paginate(page: params[:page])
  end

  def show
    @item = @notification.item
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)

    if @notification.save!
      GcmNotifyService.new.send_item_event_notification(@notification)

      flash[:notice] = "成功推播訊息"
      redirect_to admin_notifications_path
    else
      flash.now[:alert] = "請確認訊息內容"
      render :new
    end
  end

  def get_items
    category = Category.find(params[:category_id])
    items_list = category.items.on_shelf.order("id")
    render json: items_list
  end

  private

  def notification_params
    params.require(:notification).permit(:item_id, :content_title, :content_text, :content_pic, :category_id)
  end

  def find_notification
    @notification = Notification.find(params[:id])
  end
end