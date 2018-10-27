class TokensController < Knock::AuthTokenController
  skip_forgery_protection
  skip_before_action :authenticate

  def create
    UserMailer.token(entity, auth_token.token).deliver_now
    head :no_content
  end

  private

  def entity_class
    User
  end
end
