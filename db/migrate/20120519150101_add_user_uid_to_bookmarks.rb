class AddUserUidToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :user_uid, :integer
  end
end
