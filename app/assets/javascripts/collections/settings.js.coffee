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

