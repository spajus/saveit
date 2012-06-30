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
    @_loadSetting 'linkTarget', 'same', 'radio'
    @_loadSetting 'confirmDelete', 'confirm'
    @_loadSetting 'useTags', 'false'

    @

  save: (event) ->
    event.preventDefault()

    @_saveSetting 'pageSize'
    @_saveSetting 'linkTarget', 'radio'
    @_saveSetting 'confirmDelete'
    @_saveSetting 'useTags'

    show_alert 'Settings saved!', 'success'

  # Private methods

  _loadSetting: (name, defaultValue, type='select') ->
    setting = @collection.getSetting name, defaultValue
    switch type
      when 'select' then (@$ "##{name} option[value='#{setting.get 'value'}']").attr 'selected', 'selected'
      when 'radio' then (@$ "input:radio[name='#{name}'][value='#{setting.get 'value'}']").attr 'checked', 'checked'

  _saveSetting: (name, type='select') ->
    setting = @collection.getSetting name
    switch type
      when 'select' then val = (@$ "##{name}").val()
      when 'radio' then val = (@$ "input:radio[name='#{name}']:checked").val()
    setting.save value: val

