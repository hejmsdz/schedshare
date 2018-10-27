module ControllerHelpers
  def auth_token(user)
    Knock::AuthToken.new(payload: { sub: user.id }).token
  end

  def auth_header(user)
    { 'Authorization': "Bearer #{auth_token(user)}" }
  end

  def authenticate(user)
    request.headers.merge! auth_header(user)
  end
end
