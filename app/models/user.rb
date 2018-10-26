class User < ApplicationRecord
  has_many :binaries

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
