class Bm.Views.Settings extends Backbone.View

  el: '#container'
  template: JST['settings/settings']
  events:
    'click .save': 'save'
    'click .back': 'back'
    'submit .settings-form': 'save'

  render: ->
    @$el.html @template()
    @

    @_loadSetting 'pageSize', 10
    @_loadSetting 'linkTarget', 'same', 'radio'
    @_loadSetting 'confirmDelete', 'true', 'radio'
    @_loadSetting 'useTags', 'true', 'checkbox'
    @_loadSetting 'enableSharing', 'true', 'checkbox'

    @

  back: (event) =>
    event.preventDefault()
    app.index()
    app.navigate '/'

  save: (event) ->
    event.preventDefault()

    @_saveSetting 'pageSize'
    @_saveSetting 'linkTarget', 'radio'
    @_saveSetting 'confirmDelete', 'radio'
    @_saveSetting 'useTags', 'checkbox'
    @_saveSetting 'enableSharing', 'checkbox'

    show_alert 'Settings saved!', 'success'

  # Private methods

  _loadSetting: (name, defaultValue, type='select') ->
    setting = @collection.getSetting name, defaultValue
    switch type
      when 'select' then (@$ "##{name} option[value='#{setting.get 'value'}']").attr 'selected', 'selected'
      when 'radio' then (@$ "input:radio[name='#{name}'][value='#{setting.get 'value'}']").attr 'checked', 'checked'
      when 'checkbox'
        if (setting.get 'value') is 'true'
          (@$ "##{name}").attr 'checked', 'checked'
        else
          (@$ "##{name}").removeAttr 'checked'

  _saveSetting: (name, type='select') ->
    setting = @collection.getSetting name
    switch type
      when 'select' then val = (@$ "##{name}").val()
      when 'radio' then val = (@$ "input:radio[name='#{name}']:checked").val()
      when 'checkbox'
        if (@$ "##{name}").is ':checked'
          val = 'true'
        else
          val = 'false'
    setting.save value: val

