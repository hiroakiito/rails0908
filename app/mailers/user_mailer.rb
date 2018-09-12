class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウント認証用リンクです。"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワード再設定用リンクです。"
  end
end