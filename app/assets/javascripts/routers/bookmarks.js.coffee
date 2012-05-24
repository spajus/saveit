class Bm.Routers.Bookmarks extends Backbone.Router
  routes:
    '': 'index'
    'bookmarks/:id': 'show'


  index: ->
    view = new Bm.Views.BookmarksIndex(collection: @collection)
    ($ '#container').html view.render().el

  show: (id) ->
    alert "show #{id}"
