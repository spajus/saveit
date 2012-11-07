window.Bm =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    window.app = new Bm.Routers.Bookmarks()
    window.user_settings = new Bm.Collections.Settings()
    if gon.user_settings
      window.user_settings.reset gon.user_settings

    Backbone.history.start pushState: true


$(document).ready ->
  Bm.init()
  # Clear flashes
  setTimeout (-> ($ '#app-alerts').children().fadeOut  -> ($ '#app-alerts').empty()), 5000
