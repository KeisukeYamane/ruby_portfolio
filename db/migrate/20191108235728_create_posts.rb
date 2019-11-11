class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string "title"
      t.string "content"
      t.binary "image"
      t.integer "user_id"
      t.string "post_image"
      t.timestamps
    end
  end
end
