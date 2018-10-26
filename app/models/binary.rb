class Binary < ApplicationRecord
  belongs_to :user

  validates :url, presence: true, format: { with: URI::regexp(:https) }
end
