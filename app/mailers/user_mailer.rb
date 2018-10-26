class UserMailer < ApplicationMailer
  def token(user, auth_token)
    @auth_token = auth_token
    mail to: user.email
  end
end
