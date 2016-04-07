class SessionsController < ApplicationController
  # 助理登入
  def new
    redirect_to staff_root_path if current_assistant
  end

  def create
    assistant = Assistant.find_by(email: params[:email])

    if assistant && assistant.authenticate(params[:password])
      session[:assistant_id] = assistant.id
      flash[:notice] = "Welcome, #{assistant.username}!"
      redirect_to staff_root_path
    else
      flash.now[:alert] = "請確認登入資訊!"
      render :new
    end
  end

  def destroy
    session[:assistant_id] = nil
    flash[:warning] = "你已經登出了!"
    redirect_to root_path
  end

  # 管理員登入
  def manager_new
    redirect_to admin_root_path if current_manager
  end

  def manager_create
    manager = Manager.find_by(email: params[:email])

    if manager && manager.authenticate(params[:password])
      session[:manager_id] = manager.id
      flash[:notice] = "Welcome, #{manager.username}!"
      redirect_to admin_root_path
    else
      flash.now[:alert] = "請確認登入資訊!"
      render :new
    end
  end

  def manager_destroy
    session[:manager_id] = nil
    flash[:warning] = "你已經登出了!"
    redirect_to root_path
  end
end