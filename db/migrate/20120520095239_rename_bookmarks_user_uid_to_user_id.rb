class RenameBookmarksUserUidToUserId < ActiveRecord::Migration
  def up
    rename_column :bookmarks, :user_uid, :user_id
  end

  def down
    rename_column :bookmarks, :user_id, :user_uid
  end
end
