class BinariesController < ApplicationController
  before_action :authenticate_user

  def index
    binaries = User.includes(:binaries).all.map { |user| user.binaries.last }.compact
    render json: binaries
  end

  def create
    binary = Binary.create(binary_params)
    head :created
  end

  private

  def binary_params
    params.require(:binary).permit(:version, :file).merge(user_id: current_user.id)
  end
end
