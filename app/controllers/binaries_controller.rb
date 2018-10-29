class BinariesController < ApplicationController
  before_action :authenticate_user

  def index
    @binaries = Binary.latest_per_user.with_attached_file
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
