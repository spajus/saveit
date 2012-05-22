class Bm.Views.BookmarksList extends Backbone.View

  template: JST['bookmarks/bookmark_list']
  tagName: 'ul'

  initialize: (args) ->
    @visited = args.visited
    @collection.on 'reset', @render

    @collection.on 'add', @appendBookmark
    @collection.on 'remove', @removeBookmark



  render: ->
    @$el.html @template()
    list = @$ 'ul'
    @collection.each (bookmark) =>
      if (bookmark.get 'visited') is @visited
        view = new Bm.Views.Bookmark
          model: bookmark
          collection: @collection
        list.append view.render().el
    @

  appendBookmark: (bookmark) =>
    console.log 'appending bookmark', bookmark, @
    if (bookmark.get 'visited') is @visited
      view = new Bm.Views.Bookmark
        model: bookmark
        collection: @collection
      (@$ 'ul').prepend view.render().el

  removeBookmark: (bookmark) =>
    view = new Bm.Views.Bookmark
      model: bookmark
      collection: @collection
    (@$ '#' + view.id()).remove()




