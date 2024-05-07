class CreatePostBlockTags < ActiveRecord::Migration[7.1]
  def change
    create_table :post_block_tags do |t|
      t.references :room
      

      t.timestamps
    end
  end
end
