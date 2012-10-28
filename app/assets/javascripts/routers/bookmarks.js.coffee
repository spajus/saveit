class Bm.Routers.Bookmarks extends Backbone.Router
  routes:
    '': 'index'
    '_=_': 'indexFix' # Damn Facebook
    'tags/:tag': 'index'
    'search/:q': 'search'
    'settings' : 'settings'
    'import-export' : 'importExport'

  settings: ->
    @doNavBar()
    view = new Bm.Views.Settings collection: window.user_settings
    view.render()

  index: (tag, fetch) ->
    @doNavBar()
    if gon.current_user
      view = new Bm.Views.BookmarksIndex
        tag: tag
        fetch: fetch
    else
      view = new Bm.Views.Index()
    view.render()
    @indexView = view

  importExport: ->
    @doNavBar()
    view = new Bm.Views.ImportExport()
    view.render()

  search: (q) ->
    @doNavBar()
    view = new Bm.Views.BookmarksIndex
      search_query: q
    view.render()
    @indexView = view

  indexFix: ->
    @doNavBar()
    @navigate '/'
    @indexView()

  doNavBar: ->
    @navbar or= new Bm.Views.Navbar()
    @navbar.render()

