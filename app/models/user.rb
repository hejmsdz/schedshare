class User < ApplicationRecord
  has_many :binaries

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.from_token_request(request)
    self.find(request.params[:user_id])
  end
end
