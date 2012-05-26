class Bm.Views.Settings extends Backbone.View

  template: JST['settings/settings']

  render: =>
    @$el.html @template()
    @

Bm.Views.Settings.init = ->
    # Settings modal can be called from anywhere
    ($ '#settings-link').click (event) ->
      event.preventDefault()
      settings = new Bm.Views.Settings()
      ($ '#settings').html settings.render().el
      ($ '#settings-modal').modal()

