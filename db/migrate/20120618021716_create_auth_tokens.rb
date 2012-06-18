class CreateAuthTokens < ActiveRecord::Migration
  def up
    create_table :user_tokens do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end

  def down
    drop_table :user_tokens
  end
end
