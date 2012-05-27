class Bm.Routers.Bookmarks extends Backbone.Router
  routes:
    '': 'index'
    '_=_': 'index' # Damn Facebook
    'bookmarks/:id': 'show'

  index: ->
    view = new Bm.Views.BookmarksIndex collection: @collection
    view.render()

  show: (id) ->
    alert "show #{id}"

