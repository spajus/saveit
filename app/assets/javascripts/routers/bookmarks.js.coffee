class Bm.Routers.Bookmarks extends Backbone.Router
  routes:
    '': 'index'
    '_=_': 'indexFix' # Damn Facebook
    'tags/:tag': 'index'
    'search/:q': 'search'
    'settings' : 'settings'

  settings: ->
    view = new Bm.Views.Settings collection: window.user_settings
    view.render()

  index: (tag, fetch) ->
    if gon.current_user
      view = new Bm.Views.BookmarksIndex
        tag: tag
        fetch: fetch
    else
      view = new Bm.Views.Index()
    view.render()
    @indexView = view

  search: (q) ->
    view = new Bm.Views.BookmarksIndex
      search_query: q
    view.render()
    @indexView = view

  indexFix: ->
    @navigate '/'
    @indexView()
