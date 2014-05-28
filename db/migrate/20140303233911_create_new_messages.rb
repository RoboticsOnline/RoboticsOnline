class CreateNewMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :from_user
      t.string :to_user
      t.string :title
      t.text :content
      t.datetime :published_at
      t.boolean :unread

      t.timestamps
    end
  end
end
