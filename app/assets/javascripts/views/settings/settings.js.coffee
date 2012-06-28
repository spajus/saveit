class Bm.Views.Settings extends Backbone.View

  el: '#container'
  template: JST['settings/settings']
  events:
    'click .save': 'save'
    'submit': 'save'

  render: ->
    @$el.html @template()
    @

    @_loadSetting 'pageSize', 10
    @_loadSetting 'linkTarget', 'same'
    @_loadSetting 'confirmDelete', 'confirm'
    @_loadSetting 'useTags', 'false'

    @

  save: (event) ->
    event.preventDefault()

    @_saveSetting 'pageSize'
    @_saveSetting 'linkTarget'
    @_saveSetting 'confirmDelete'
    @_saveSetting 'useTags'

    (@$ '#settings-modal').modal 'hide'
    show_alert 'Settings saved!', 'success'

  # Private methods

  _loadSetting: (name, defaultValue) ->
    setting = @collection.getSetting name, defaultValue
    (@$ "##{name} option[value='#{setting.get 'value'}']").attr 'selected', 'selected'

  _saveSetting: (name) ->
    setting = @collection.getSetting name
    setting.save value: (@$ "##{name}").val()


Bm.Views.Settings.init = ->

  # Settings modal can be called from anywhere
  # TODO FIXME
  ($ '#settings-link-obsolete').click (event) ->
    event.preventDefault()
    clear_alerts()
    settings = new Bm.Views.Settings collection: window.user_settings
    ($ '#settings').html settings.render().el
    ($ '#settings-modal').modal()

