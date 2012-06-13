module ApplicationHelper

  def bookmarkify(&block)
    content = with_output_buffer &block
    content.gsub(/(\s*\n|\s*;\s*)/, '')
  end

  def full_image_path(img)
    root_url.chomp('/') + asset_path(img)
  end

  def full_url(relative_url)
    root_url.chomp('/') + relative_url
  end

end
