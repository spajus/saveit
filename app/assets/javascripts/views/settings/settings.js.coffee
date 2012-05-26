class Bm.Views.Settings extends Backbone.View

  template: JST['settings/settings']
  events:
    'click .save': 'save'
    'submit': 'save'

  render: ->
    @$el.html @template()
    @sLinkTarget = @collection.getSetting 'linkTarget', 'same'
    (@$ "#sLinkTarget option[value='#{@sLinkTarget.get 'value'}']")
      .attr 'selected', 'selected'
    @

  save: (event) ->
    event.preventDefault()
    console.log 'saving', @sLinkTarget, @collection
    @sLinkTarget.save value: (@$ '#sLinkTarget').val(), {wait: true}
    (@$ '#settings-modal').modal 'hide'
    show_alert 'Settings saved!', 'success'




Bm.Views.Settings.init = ->
  window.user_settings = new Bm.Collections.Settings()
  if gon.user_settings
    window.user_settings.reset gon.user_settings

  # Settings modal can be called from anywhere
  ($ '#settings-link').click (event) ->
    event.preventDefault()
    clear_alerts()
    settings = new Bm.Views.Settings collection: window.user_settings
    ($ '#settings').html settings.render().el
    ($ '#settings-modal').modal()

