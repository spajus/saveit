class IoController < ApplicationController

  def export
    redirect_to root_url unless current_user
    builder = Markio::Builder.new(title: "Bookmarks from saveit.in")
    current_user.bookmarks.each do |b|
      builder.bookmarks << Markio::Bookmark.create(
        title: b.title,
        href: b.url,
        folders: b.tag_names,
        add_date: b.created_at,
        last_visit: b.visited ? b.updated_at : b.created_at,
        last_modified: b.updated_at
      )
    end
    send_data builder.build_string,
      type: "application/html; charset=UTF-8",
      disposition: "attachment; filename=saveit-bookmarks.html"
  end

  def import 
    if current_user
      bookmarks = Markio::parse(params["new-bookmarks"].read)
      if bookmarks.length == 0
        flash[:error] = "Didn't find any bookmarks to import. You should upload HTML file."
        redirect_to "/import-export"
        return
      end
      bookmarks.each do |b|
        book = Bookmark.find_or_create_by_user_id_and_url current_user.id, b.href
        book.title = b.title
        book.tag_names ||= []
        book.tag_names += b.folders + ["Imported"]
        unless book.save
          binding.pry
        end
      end
      flash[:success] = "Imported #{bookmarks.length} bookmarks!"
    else
      flash[:error] = "You are not logged in"
    end
    redirect_to root_url
    
  end

end
