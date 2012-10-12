module TagsHelper
  def available_tags_js
    if current_user
      current_user.tags.select("name").collect {|t| t.name}.to_s.html_safe
    end
  end
end
