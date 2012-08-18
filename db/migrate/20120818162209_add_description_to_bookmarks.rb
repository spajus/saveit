class AddDescriptionToBookmarks < ActiveRecord::Migration
  def up
    add_column :bookmarks, :description, :text
    add_index :bookmarks, :description
  end

  def down
    remove_index :bookmarks, :description
    remove_column :bookmarks, :description
  end
end
