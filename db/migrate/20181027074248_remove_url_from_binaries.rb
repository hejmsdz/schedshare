class RemoveUrlFromBinaries < ActiveRecord::Migration[5.2]
  def change
    remove_column :binaries, :url, :string
  end
end
