class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :title
      t.string :url
      t.boolean :visited

      t.timestamps
    end
  end
end
