module ApplicationHelper
  def bookmarkify(&block)
    content = with_output_buffer &block
    content.gsub(/(\s*\n|\s*;\s*)/, '')
  end
end
