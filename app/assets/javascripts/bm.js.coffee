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
  Bm.init() if gon.current_user

  ($ '.nav-link').click (e) ->
      app.navigate e.target.pathname, trigger: true
      e.preventDefault()
      if e.target.pathname is '/'
        app.indexView.collection.fetch()


