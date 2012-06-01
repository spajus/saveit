window.Bm =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    window.app = new Bm.Routers.Bookmarks()
    Bm.Views.Settings.init()
    Backbone.history.start pushState: true

$(document).ready ->
  Bm.init() if gon.current_user


