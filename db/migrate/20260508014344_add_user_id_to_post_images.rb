class AddUserIdToPostImages < ActiveRecord::Migration[8.0]
  def change
    add_column :post_images, :user_id, :integer
  end
end
