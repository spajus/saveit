class UserImage < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :image
    end
  end
end
