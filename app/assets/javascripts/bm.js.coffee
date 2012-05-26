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

  # Settings modal can be called from anywhere
  ($ '#settings-link').click (event) ->
    event.preventDefault()
    settings = new Bm.Views.Settings()
    ($ '#settings').html settings.render().el
    ($ '#settings-modal').modal()

  ($ '#error-alert .close').click (event) ->
    event.preventDefault()
    ($ '#error-alert').fadeOut ->
      ($ '#error-alert .content').empty()


