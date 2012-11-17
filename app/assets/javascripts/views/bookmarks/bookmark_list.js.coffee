class Bm.Views.BookmarksList extends Backbone.View

  template:
    normal: JST['bookmarks/bookmark_list']
    empty: JST['bookmarks/bookmark_list_empty']
    empty_search: JST['bookmarks/bookmark_list_empty_search']

  events:
    'click .bookmarklet a' : 'bookmarkletHelp'

  bookmarkletHelp: (event) ->
    Bm.Views.Bookmarklet::bookmarkletHelp event

  initialize: (options) ->
    @searching = options.searching
    @collection.on 'reset', @render

    @collection.on 'add', @appendBookmark
    @collection.on 'remove', @removeBookmark

  render: =>
    if @collection.length > 0
      @$el.html @template.normal
    else
      if @searching
        @$el.html @template.empty_search
      else
        @$el.html @template.empty bookmarklet_js: gon.bookmarklet_js

    @pag = new Bm.Views.Pagination
      collection: @collection
      el: @$ '.pagination'
    list = @$ '.bookmarks'
    @collection.each (bookmark) =>
      view = new Bm.Views.Bookmark
        model: bookmark
        collection: @collection
      list.append view.render().el
    @loadSharing()
    @

  loadSharing: ->
    twttr.widgets.load() if twttr and twttr.widgets
    FB.XFBML.parse @el if typeof(FB) != 'undefined'
    gapi.plus.go() if gapi
    @

  appendBookmark: (bookmark) =>
    if @collection.length is 1
      @render()
      return
    view = new Bm.Views.Bookmark
      model: bookmark
      collection: @collection
    (@$ '.bookmarks').prepend view.render().el
    @loadSharing()
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
    @loadSharing()
    @
