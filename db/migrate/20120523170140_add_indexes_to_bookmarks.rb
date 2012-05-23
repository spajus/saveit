class AddIndexesToBookmarks < ActiveRecord::Migration
  def up
    add_index :bookmarks, :url
    add_index :bookmarks, :user_id
  end

  def down
    remove_index :bookmarks, :url
    remove_index :bookmarks, :user_id
  end
end
