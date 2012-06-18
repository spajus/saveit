class Bm.Routers.Bookmarks extends Backbone.Router
  routes:
    '': 'index'
    '_=_': 'indexFix' # Damn Facebook
    'tags/:tag': 'index'
    'search/:q': 'search'
    'users' : 'users'

  users: () ->
    console.log 'wtfff'

  index: (tag, fetch) ->
    view = new Bm.Views.BookmarksIndex
      tag: tag
      fetch: fetch
    view.render()
    @index = view

  search: (q) ->
    view = new Bm.Views.BookmarksIndex
      search_query: q
    view.render()
    @index = view

  indexFix: ->
    @navigate '/'
    @index()
