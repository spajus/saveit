class Bm.Collections.Settings extends Backbone.Collection

  model: Bm.Models.Setting
  url: '/api/settings'

  getSetting: (key, defaultValue=null) ->
    result = null
    @each (model) ->
      if (model.get 'key') is key
        result = model
        return
    unless result
      result = @create new Bm.Models.Setting key: key, value: defaultValue
    result

  getSettingValue: (key, defaultValue=null) ->
    setting = @getSetting(key, defaultValue)
    setting.get 'value'

  # Helper methods

  getLinkTarget: ->
    @getSettingValue 'linkTarget', 'same'

  getConfirmDelete: ->
    (@getSettingValue 'confirmDelete', 'true') is 'true'

  getUseTags: ->
    (@getSettingValue 'useTags', 'true') is 'true'

  getPageSize: ->
    parseInt(@getSettingValue 'pageSize', 10)

