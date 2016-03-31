class Admin::UsersController < AdminController
  layout "admin"

  # 針對import_usere關掉表單token驗證
  # skip_before_action :verify_authenticity_token, only: [:import_user]

  def index
    @user_page = @users = User.recent.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.includes(orders: [:info, :items]).find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
end