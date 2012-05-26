class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end
    add_index :tags, :name
    add_index :tags, :user_id
  end

  def down
    drop_table :tags
  end
end
