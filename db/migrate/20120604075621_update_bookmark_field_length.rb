class UpdateBookmarkFieldLength < ActiveRecord::Migration
  def up
    change_table :bookmarks do |t|
      t.change :url, :string, limit: 2048 # Fails with postgres
      t.change :title, :string, limit: 2048
    end
  end

  def down
    t.change :url, :string
    t.change :title, :string
  end
end
