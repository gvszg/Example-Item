class Admin::MessagesController < AdminController
  before_action :require_manager

  def index
    @messages = Message.all.paginate(:page => params[:page])
  end

  def new
    @message = Message.new
  end

  def create
    # binding.pry
    @message = Message.new(message_params)
    
    if @message.save
      flash[:notice] = "成功新增訊息"
      redirect_to admin_messages_path
    else
      flash[:danger] = "請檢查訊息內容是否有誤"
      render :new
    end
  end

  def show
    @message = Message.find(params[:id])
    @send_records = @message.users
  end

  def new_message_record
    @message = Message.find(params[:id])
    @users = User.all
    # @registion_users = User.where()
  end

  def create_message_record
    # @message = Message.find(params[:message_id])
    # @message = Message.find(params[:id])
    # @user = User.find(params[:user_id])
    binding.pry
    
    if MessageRecord.create(message_id: params[:id], user_id: params[:user_id])
      flash[:notice] = "成功發送通知訊息"
      redirect_to :back
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :content, :message_type, user_ids: [])
    # params.require(:message).permit(:title, :content, :message_type, user_ids: []).tap {|p| p[:message_type].to_i if p[:message_type]}
  end
end