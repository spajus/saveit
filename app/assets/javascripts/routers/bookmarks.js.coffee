class Bm.Routers.Bookmarks extends Backbone.Router
  routes:
    '': 'index'
    'bookmarks/:id': 'show'

  initialize: ->
    @collection = new Bm.Collections.Bookmarks()
    @collection.reset(($ '#container').data 'bookmarks')


  index: ->
    view = new Bm.Views.BookmarksIndex(collection: @collection)
    ($ '#container').html view.render().el

  show: (id) ->
    alert "show #{id}"
