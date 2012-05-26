class CreateTaggings < ActiveRecord::Migration
  def up
    create_table :taggings do |t|
      t.integer :bookmark_id
      t.integer :tag_id
    end
  end

  def down
    drop_table :taggings
  end
end
