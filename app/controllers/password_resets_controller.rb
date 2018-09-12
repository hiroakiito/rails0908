class PasswordResetsController < ApplicationController
  before_action :get_user, only:[:edit, :update]
  before_action :valid_user, only:[:edit, :update]
  before_action :check_expiration, only:[:edit, :update]
  
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "登録されているメールアドレスへ再設定用のメールを送信しました"
      redirect_to root_url
    else
      flash.now[:danger] = "そのメールアドレスは登録されていません"
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @userflash[:success] = "パスワードが再設定されました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  
  def get_user
    @user = User.find_by(email: params[:email])
  end
  
  # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
    
    # トークンが期限切れかどうか確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワード再設定の有効期間がきれています。もう一度再設定を行ってください。"
        redirect_to new_password_reset_url
      end
    end
end
