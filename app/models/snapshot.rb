class Snapshot < ActiveRecord::Base
  attr_accessible :url, :image
  has_attached_file :image, styles: {
      thumb: "100x100#",
      original: "300"
  },
  storage: :s3,
  s3_credentials: "#{Rails.root}/config/s3.yml",
  s3_protocol: "https",
  path: "/:style/:id/:filename"

  def self.take(url)
    snap = Snapshot.find_or_create_by_url(url)
    unless snap.image?
      begin
        kit = IMGKit.new(url, width: 1000, height: 1000)
        img = kit.to_img
        temp = Tempfile.new([Digest::MD5.hexdigest(url), '.png'], encoding: 'ascii-8bit')
        temp.write(img)
        temp.flush
        snap.image = temp
        snap.save!
        temp.close
        temp.unlink
      rescue
        #TODO mark Snapshot as errorneous and save error cause (for debugging)
      end
    end
    snap
  end

  def self.image_for_url(url, style)
    snap = Snapshot.find_by_url(url)
    if snap and snap.image?
      snap.image.url(style)
    else
      "/images/#{style}/missing.png"
    end
  end
end
