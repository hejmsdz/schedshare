class BinariesController < ApplicationController
  before_action :authenticate_user

  def index
    binaries = User.includes(:binaries).all.map { |user| user.binaries.last }.compact
    render json: binaries
  end
end
