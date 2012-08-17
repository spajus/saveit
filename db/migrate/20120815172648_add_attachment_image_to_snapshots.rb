class AddAttachmentImageToSnapshots < ActiveRecord::Migration
  def self.up
    change_table :snapshots do |t|
      t.has_attached_file :image
    end
  end

  def self.down
    drop_attached_file :snapshots, :image
  end
end
