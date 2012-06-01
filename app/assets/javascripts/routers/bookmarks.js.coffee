class Bm.Routers.Bookmarks extends Backbone.Router
  routes:
    '': 'index'
    '_=_': 'indexFix' # Damn Facebook
    'tags/:tag': 'index'

  index: (tag, fetch) ->
    view = new Bm.Views.BookmarksIndex
      tag: tag
      fetch: fetch
    view.render()
    @index = view


  indexFix: ->
    @navigate '/'
    @index()



