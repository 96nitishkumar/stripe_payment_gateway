class CreateFaqBlockFaqs < ActiveRecord::Migration[7.1]
  def change
    create_table :faq_block_faqs do |t|
      t.string :title
      t.string :description
      t.string :category

      t.timestamps
    end
  end
end
