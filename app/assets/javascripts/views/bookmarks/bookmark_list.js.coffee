class Bm.Views.BookmarksList extends Backbone.View

  template: JST['bookmarks/bookmark_list']

  initialize: (args) ->
    @el = args.el
    @visited = args.visited
    @title = args.title
    @collection.on 'reset', @render

    @collection.on 'add', @appendBookmark
    @collection.on 'remove', @removeBookmark

  render: =>
    @$el.html @template title: @title
    @pag = new Bm.Views.Pagination
      collection: @collection
      el: @$ '.pagination'
    list = @$ 'tbody'
    @collection.each (bookmark) =>
      if (bookmark.get 'visited') is @visited
        view = new Bm.Views.Bookmark
          model: bookmark
          collection: @collection
        list.append view.render().el
    @

  appendBookmark: (bookmark) =>
    if (bookmark.get 'visited') is @visited
      view = new Bm.Views.Bookmark
        model: bookmark
        collection: @collection
      (@$ 'tbody').prepend view.render().el
    @

  removeBookmark: (bookmark) =>
    view = new Bm.Views.Bookmark
      model: bookmark
      collection: @collection
    (@$ '#' + view.id()).remove()
    @collection.trigger 'tags-changed' # Tag bar needs to know
    if @collection.size() is 0
      setTimeout  =>
          page = @collection.getPage()
          if page > 1
            @collection.setPage page - 1
          @collection.fetch()
        , 10
    @
