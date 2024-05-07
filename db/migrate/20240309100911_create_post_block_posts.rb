class CreatePostBlockPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :post_block_posts do |t|
      t.references :user
      t.references :room
      t.string :title

      t.timestamps
    end
  end
end
