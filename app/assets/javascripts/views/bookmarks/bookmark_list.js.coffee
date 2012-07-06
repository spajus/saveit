class Bm.Views.BookmarksList extends Backbone.View

  template:
    normal: JST['bookmarks/bookmark_list']
    empty:
      visited: JST['bookmarks/bookmark_list_empty_visited']
      unvisited: JST['bookmarks/bookmark_list_empty_unvisited']

  events:
    'click .bookmarklet a' : 'bookmarkletHelp'

  bookmarkletHelp: (event) ->
    Bm.Views.Bookmarklet::bookmarkletHelp event

  initialize: (args) ->
    @visited = args.visited
    @title = args.title
    @collection.on 'reset', @render

    @collection.on 'add', @appendBookmark
    @collection.on 'remove', @removeBookmark

  render: =>
    if @collection.length > 0
      @$el.html @template.normal title: @title
    else
      if @visited
        @$el.html @template.empty.visited title: @title
      else
        @$el.html @template.empty.unvisited
          title: @title
          bookmarklet_js: gon.bookmarklet_js

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
    @$el.droppable
      hoverClass: 'tag-hover'
      drop: (event, ui) =>
        event.preventDefault()

        bookmark = ui.draggable.data 'bookmark'
        unless @visited is bookmark.get 'visited'
          ui.draggable.draggable 'option', 'revert', false
          setTimeout( =>
            bookmark.set 'visited', @visited
            bookmark.collection.remove bookmark
            @collection.add bookmark
            bookmark.save()
          , 10)

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
