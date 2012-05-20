class Bm.Views.Bookmark extends Backbone.View

  template: JST['bookmarks/bookmark']
  tagName: 'li'

  render: ->
    @$el.html @template(bookmark: @model)
    @
