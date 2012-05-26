class Bm.Views.TagBar extends Backbone.View

  template: JST['tags/tag_bar']
  el: '#tag-bar'

  render: =>
    @$el.html @template()
    @
