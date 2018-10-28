class TokensController < Knock::AuthTokenController
  skip_forgery_protection
  skip_before_action :authenticate

  def create
    3 / 0
    UserMailer.token(entity, auth_token.token).deliver_now
    head :no_content
  end

  private

  def entity_class
    User
  end
end
