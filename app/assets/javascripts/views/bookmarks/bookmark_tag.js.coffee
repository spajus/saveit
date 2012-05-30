class Bm.Views.BookmarkTag extends Backbone.View

  template: JST['bookmarks/bookmark_tag']
  tagName: 'span'

  initialize: (opts) ->
    @tag = opts.tag


  render: ->
    @$el.html @template tag: @tag
    @
