class Bm.Views.Bookmarklet extends Backbone.View

  template: JST['bookmarklets/bookmarklet']

  render: ->
    @$el.html @template settings: ($ '#backbone-settings').data 'settings'
    @
