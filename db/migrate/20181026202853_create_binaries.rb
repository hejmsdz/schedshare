class CreateBinaries < ActiveRecord::Migration[5.2]
  def change
    create_table :binaries do |t|
      t.string :url, null: false
      t.references :user, foreign_key: true, null: false
      t.string :version

      t.timestamps
    end
  end
end
