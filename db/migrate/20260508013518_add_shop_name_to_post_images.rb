class AddShopNameToPostImages < ActiveRecord::Migration[8.0]
  def change
    add_column :post_images, :shop_name, :string
  end
end
