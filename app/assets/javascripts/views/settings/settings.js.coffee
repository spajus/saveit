class Bm.Views.Settings extends Backbone.View

  template: JST['settings/settings']

  render: =>
    @$el.html @template()
    @
