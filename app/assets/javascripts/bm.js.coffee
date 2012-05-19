window.Bm =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Bm.Routers.Bookmarks()
    Backbone.history.start pushState: true

$(document).ready ->
  Bm.init()
