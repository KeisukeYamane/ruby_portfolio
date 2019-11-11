class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string "name"
      t.string "email"
      t.string "password_digest", null: false
      t.string "image"
      t.boolean "admin", default: false
      t.timestamps
    end
  end
end
