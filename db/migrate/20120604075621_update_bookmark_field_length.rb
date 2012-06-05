class UpdateBookmarkFieldLength < ActiveRecord::Migration
  def up
    change_table :bookmarks do |t|
      t.change :url, :text, limit: 2048
      t.change :title, :text, limit: 2048
    end
  end

  def down
    t.change :url, :string
    t.change :title, :string
  end
end
