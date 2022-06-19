# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user)
  end

　# GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected
   # 退会しているかを判断するメソッド
  def customer_state
  ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:customer][:email])
  ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@user
  ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @user.valid_password?(params[:customer][:password]) && (@user.is_active == false)
      redirect_to new_customer_registration_path
    ## 【処理内容3】
    end
  end
end
