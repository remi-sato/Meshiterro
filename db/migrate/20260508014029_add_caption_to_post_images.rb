class AddCaptionToPostImages < ActiveRecord::Migration[8.0]
  def change
    add_column :post_images, :caption, :text
  end
end
