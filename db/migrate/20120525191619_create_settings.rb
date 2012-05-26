class CreateSettings < ActiveRecord::Migration
  def up
    create_table :settings do |t|
      t.integer :user_id
      t.string :key
      t.string :value

      t.timestamps
    end
    add_index :settings, :user_id
    add_index :settings, :key
  end

  def down
    drop_table :settings
  end
end
