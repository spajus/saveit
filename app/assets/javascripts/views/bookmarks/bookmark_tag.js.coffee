class Bm.Views.BookmarkTag extends Backbone.View

  template: JST['bookmarks/bookmark_tag']

  render: ->
    @$el.html @template tag: @model
