class RemoveActsAsTaggableOn < ActiveRecord::Migration
  def up
    drop_table :taggings
    drop_table :tags
  end

  def down
  end
end
