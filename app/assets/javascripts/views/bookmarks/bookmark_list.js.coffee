class Bm.Views.BookmarksList extends Backbone.View

  template:
    normal: JST['bookmarks/bookmark_list']
    empty: JST['bookmarks/bookmark_list_empty']

  events:
    'click .bookmarklet a' : 'bookmarkletHelp'

  bookmarkletHelp: (event) ->
    Bm.Views.Bookmarklet::bookmarkletHelp event

  initialize: (args) ->
    @title = args.title
    @collection.on 'reset', @render

    @collection.on 'add', @appendBookmark
    @collection.on 'remove', @removeBookmark

  render: =>
    if @collection.length > 0
      @$el.html @template.normal
    else
      @$el.html @template.empty bookmarklet_js: gon.bookmarklet_js

    @pag = new Bm.Views.Pagination
      collection: @collection
      el: @$ '.pagination'
    list = @$ 'ul'
    @collection.each (bookmark) =>
      view = new Bm.Views.Bookmark
        model: bookmark
        collection: @collection
      list.append view.render().el
    @

  appendBookmark: (bookmark) =>
    if @collection.length is 1
      @render()
      return
    view = new Bm.Views.Bookmark
      model: bookmark
      collection: @collection
    (@$ 'ul').prepend view.render().el
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
