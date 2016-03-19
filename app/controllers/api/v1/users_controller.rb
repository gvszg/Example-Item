class Api::V1::UsersController < ApiController
  def show
    user = User.find_by(uid: params[:id])

    render json: user  
  end

  def create
    begin
      user = User.new
      user.user_name = params[:user_name]
      user.real_name = params[:real_name]
      user.gender = params[:gender]
      user.phone = params[:phone]
      user.address = params[:address]
      user.uid = params[:uid]
      user.save!
      render json: "success"
    rescue Exception => e
      render json: "error"
    end
  end
end