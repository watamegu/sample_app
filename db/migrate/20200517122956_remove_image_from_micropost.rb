class RemoveImageFromMicropost < ActiveRecord::Migration[6.0]
  def change

    remove_column :microposts, :image, :string
  end
end
