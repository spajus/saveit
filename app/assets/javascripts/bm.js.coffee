window.Bm =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Bm.Routers.Bookmarks()
    Bm.Views.Settings.init()
    Backbone.history.start pushState: true

$(document).ready ->
  Bm.init()


