class TokensController < Knock::AuthTokenController
  skip_forgery_protection
  skip_before_action :authenticate

  def entity_class
    User
  end
end
