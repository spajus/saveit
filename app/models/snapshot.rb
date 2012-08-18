class Snapshot < ActiveRecord::Base
  attr_accessible :url, :image
  has_attached_file :image, styles: {
      thumb: "200",
      normal: "400",
      original: "600"
  },
  storage: :s3,
  s3_credentials: "#{Rails.root}/config/s3.yml",
  path: "/:style/:id/:filename"

  def self.take(url)
    snap = Snapshot.find_or_create_by_url(url)
    unless snap.image?
      kit = IMGKit.new(url, width: 1000, height: 1000)
      img = kit.to_img
      img = MiniMagick::Image.read(img)
      temp = Tempfile.new([Digest::MD5.hexdigest(url), '.png'])
      img.write(temp.path)
      snap.image = temp
      snap.save!
      temp.close
      temp.unlink
    end
    snap
  end
end
